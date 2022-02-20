unit u_laporan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, StdCtrls, Buttons, ComCtrls,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, frxPreview, frxClass,
  frxDBSet, frxExportPDF, frxExportBIFF, frxDesgn, frxCross;

type
  Tf_laporan = class(TForm)
    GroupBox1: TGroupBox;
    btnTutup: TBitBtn;
    btnCetak: TBitBtn;
    cbLaporan: TComboBox;
    lbLaporan: TLabel;
    DTPAwal: TDateTimePicker;
    DTPAkhir: TDateTimePicker;
    lbTanggal: TLabel;
    lbSampai: TLabel;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    ZQLaporan1: TZQuery;
    frxDBDataset2: TfrxDBDataset;
    ZQLaporan2: TZQuery;
    frxPDFExport1: TfrxPDFExport;
    frxBIFFExport1: TfrxBIFFExport;
    frxDesigner1: TfrxDesigner;
    frxCrossObject1: TfrxCrossObject;
    procedure btnTutupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbLaporanChange(Sender: TObject);
    procedure btnCetakClick(Sender: TObject);
    procedure cbLaporanKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    NAMA,ALAMAT,KOTA,PROV,TELP,EMAIL,WWW: String;
  end;

  TString_ = class(TObject)
  private
    fStr: String;
  public
    constructor Create(const AStr: String);
  property
    Str: String read FStr Write FStr;
  end;

var
  f_laporan: Tf_laporan;

implementation

uses DateUtils, u_server, u_dm;

{$R *.dfm}

{Kode untuk Form}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_laporan.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_laporan.btnTutupClick(Sender: TObject);
begin
 Close;
end;

constructor TString_.Create(const AStr: String);
begin
 inherited Create;
 FStr := AStr;
end;

function ComboIndex(Combo: TCustomComboBox; Kode: String): Integer;
var
 i: Integer;
begin
 i := 0;
 while i < Combo.Items.Count do
  begin
   if TString_(Combo.Items.Objects[i]).Str = Kode then
    begin
     ComboIndex := i;
    end;
   i := i+1;
  end;
end;

procedure Tf_laporan.FormCreate(Sender: TObject);
begin
 cbLaporan.Clear;
 cbLaporan.Items.AddObject('- Pilih Jenis Laporan', TString_.Create('-'));
 cbLaporan.Items.AddObject('Daftar Data Guru / Pengajar', TString_.Create('1'));
 cbLaporan.Items.AddObject('Daftar Data Siswa', TString_.Create('2'));
 cbLaporan.Items.AddObject('Daftar Data Pengampu Mata Pelajaran', TString_.Create('3'));
 cbLaporan.Items.AddObject('Daftar Jadwal Penggunaan Lab', TString_.Create('4'));
 cbLaporan.Items.AddObject('Laporan Penggunaan Lab', TString_.Create('5'));
 cbLaporan.ItemIndex := 0;

 DTPAwal.Enabled  := False;
 DTPAkhir.Enabled := False;

 DTPAwal.Date  := StartOfTheMonth(Now);
 DTPAkhir.Date := EndOfTheMonth(Now);

 Height := 210;
 Width  := 449;
end;

procedure Tf_laporan.cbLaporanChange(Sender: TObject);
begin
 if cbLaporan.ItemIndex=5 then
  begin
   DTPAwal.Enabled  := True;
   DTPAkhir.Enabled := True;
  end
 else
  begin
   DTPAwal.Enabled  := False;
   DTPAkhir.Enabled := False;
  end;
end;

procedure isi_header;
begin
 f_laporan.frxReport1.Variables.Variables['NM_DINAS'] := '''' + 'DINAS PENDIDIKAN' + '''';
 f_laporan.frxReport1.Variables.Variables['NM_INSTANSI'] := '''' +f_laporan.NAMA+ '''';
 f_laporan.frxReport1.Variables.Variables['ALAMAT_INSTANSI'] := '''' +f_laporan.ALAMAT+', Kota '+f_laporan.KOTA+', No. Telp.'+f_laporan.TELP+ '''';
 if (f_laporan.WWW<>'') or (f_laporan.WWW<>'-') then
  f_laporan.frxReport1.Variables.Variables['EMAIL_INSTANSI'] := '''' +'email: '+f_laporan.EMAIL+' | website: '+f_laporan.WWW+ ''''
 else
  f_laporan.frxReport1.Variables.Variables['EMAIL_INSTANSI'] := '''' +'email: '+f_laporan.EMAIL+ ''''
end;

procedure Tf_laporan.btnCetakClick(Sender: TObject);
var
 query_tambahan: String;
begin
 case cbLaporan.ItemIndex of
  0 : begin
       MessageDlg('Peringatan : Jenis Laporan belum dipilih, silahkan pilih jenis laporan.', mtWarning, [mbOK], 0);
       cbLaporan.SetFocus;
      end;
  1 : begin
       with ZQLaporan1 do
        begin
         Close;
         SQL.Clear;
         SQL.Text := 'SELECT NO_INDUK_PEGAWAI, NM_GURU, TEMPAT_LAHIR, TGL_LAHIR, '+
                     'CONCAT(TEMPAT_LAHIR," (",DATE_FORMAT(TGL_LAHIR, "%e/%m/%Y"),")") AS TTL, '+
                     '(CASE WHEN JENIS_KELAMIN=''L'' THEN ''Laki-laki'' ELSE ''Perempuan'' END) AS JENIS_KELAMIN, '+
                     'AGAMA, NO_TELP, ALAMAT '+
                     'FROM T_GURU '+
                     'WHERE NO_INDUK_PEGAWAI<>''XXX99AAA'' '+
                     'ORDER BY NM_GURU ';
         Open;
        end;

       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'/FReport/fr_guru.fr3');
       isi_header;
       frxReport1.Variables.Variables['JUDUL'] := '''' + 'DAFTAR DATA GURU / PENGAJAR' + '''';
       frxReport1.ShowReport();
      end;
  2 : begin
       with ZQLaporan1 do
        begin
         Close;
         SQL.Clear;
         SQL.Text := 'SELECT A.NO_INDUK_SISWA, A.NM_SISWA, A.TEMPAT_LAHIR, A.TGL_LAHIR, '+
                     'CONCAT(A.TEMPAT_LAHIR," (",DATE_FORMAT(A.TGL_LAHIR, "%e/%m/%Y"),")") AS TTL, '+
                     '(CASE WHEN A.JENIS_KELAMIN=''L'' THEN ''Laki-laki'' ELSE ''Perempuan'' END) AS JENIS_KELAMIN, '+
                     'A.AGAMA, A.NO_TELP, A.ALAMAT, A.ID_KELAS, A.ID_JURUSAN, B.NM_KELAS, C.NM_JURUSAN '+
                     'FROM T_SISWA A, T_KELAS B, T_JURUSAN C '+
                     'WHERE A.ID_KELAS=B.ID_KELAS AND A.ID_JURUSAN=C.ID_JURUSAN '+
                     'ORDER BY ID_JURUSAN, ID_KELAS, NM_SISWA';
         Open;
        end;

       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'/FReport/fr_siswa.fr3');
       isi_header;
       frxReport1.Variables.Variables['JUDUL'] := '''' + 'DAFTAR DATA SISWA' + '''';
       frxReport1.ShowReport();
      end;
  3 : begin
       with ZQLaporan1 do
        begin
         Close;
         SQL.Clear;
         SQL.Text := 'SELECT A.ID_MAPEL_AMPU, A.ID_MAPEL, B.NM_MAPEL, '+
                     'A.NO_INDUK_PEGAWAI, C.NM_GURU, A.ID_KELAS, D.NM_KELAS, '+
                     'A.ID_JURUSAN, E.NM_JURUSAN '+
                     'FROM T_MAPEL_AMPU A, T_MAPEL B, T_GURU C, '+
                     'T_KELAS D, T_JURUSAN E '+
                     'WHERE A.ID_MAPEL=B.ID_MAPEL AND A.NO_INDUK_PEGAWAI=C.NO_INDUK_PEGAWAI '+
                     'AND A.ID_KELAS=D.ID_KELAS AND A.ID_JURUSAN=E.ID_JURUSAN '+
                     'ORDER BY ID_JURUSAN, ID_KELAS, NM_GURU';
         Open;
        end;

       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'/FReport/fr_pengampu.fr3');
       isi_header;
       frxReport1.Variables.Variables['JUDUL'] := '''' + 'DAFTAR DATA GURU PENGAMPU MATA PELAJARAN' + '''';
       frxReport1.ShowReport();
      end;
  4 : begin
       with ZQLaporan1 do
        begin
         Close;
         SQL.Clear;
         SQL.Text := 'SELECT A.TAHUN_AJAR, A.HARI, A.JAM_MULAI, A.JAM_SELESAI, '+
                     'A.ID_JADWAL, A.ID_LAB, B.NM_LAB, A.ID_MAPEL_AMPU, '+
                     'C.ID_MAPEL, D.NM_MAPEL, C.NO_INDUK_PEGAWAI, E.NM_GURU, '+
                     'C.ID_KELAS, F.NM_KELAS, C.ID_JURUSAN, G.NM_JURUSAN '+
                     'FROM T_JADWAL_LAB A, T_LAB B, '+
                     'T_MAPEL_AMPU C LEFT OUTER JOIN T_MAPEL D ON C.ID_MAPEL=D.ID_MAPEL '+
                     '               LEFT OUTER JOIN T_GURU E ON C.NO_INDUK_PEGAWAI=E.NO_INDUK_PEGAWAI '+
                     '               LEFT OUTER JOIN T_KELAS F ON C.ID_KELAS=F.ID_KELAS '+
                     '               LEFT OUTER JOIN T_JURUSAN G ON C.ID_JURUSAN=G.ID_JURUSAN '+
                     'WHERE A.ID_LAB=B.ID_LAB AND A.ID_MAPEL_AMPU=C.ID_MAPEL_AMPU '+
                     'ORDER BY TAHUN_AJAR';
         Open;
        end;

       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'/FReport/fr_jadwal.fr3');
       isi_header;
       frxReport1.Variables.Variables['JUDUL'] := '''' + 'JADWAL PENGGUNAAN LABORATORIUM' + '''';
       frxReport1.ShowReport();
      end;
  5 : begin
       query_tambahan := '';
       if DMServer.ID_JADWAL<>'' then
        query_tambahan := ' AND A.ID_JADWAL='+#39+DMServer.ID_JADWAL+#39;

       query_tambahan := query_tambahan + ' AND SUBSTRING(A.ID_PEMAKAIAN,1,8) BETWEEN '+
                         #39+FormatDateTime('yyyymmdd', DTPAwal.Date)+#39+' AND '+
                         #39+FormatDateTime('yyyymmdd', DTPAkhir.Date)+#39; 

       with ZQLaporan2 do
        begin
         Close;
         SQL.Clear;
         SQL.Text := 'SELECT A.ID_PEMAKAIAN, A.NO_INDUK_SISWA, B.NM_SISWA, '+
                     'B.ID_JURUSAN, H.NM_JURUSAN, B.ID_KELAS, G.NM_KELAS, '+
                     'A.ID_JADWAL, C.ID_LAB, C.HARI, C.ID_MAPEL_AMPU, C.JAM_MULAI, '+
                     'C.JAM_SELESAI, C.TAHUN_AJAR, D.ID_MAPEL, E.NM_MAPEL, '+
                     'D.NO_INDUK_PEGAWAI, F.NM_GURU, A.JAM_LOGIN, A.JAM_LOGOUT '+
                     'FROM T_HISTORI_PEMAKAIAN A, T_SISWA B, T_JADWAL_LAB C, '+
                     'T_MAPEL_AMPU D, T_MAPEL E, T_GURU F, T_KELAS G, T_JURUSAN H '+
                     'WHERE A.NO_INDUK_SISWA=B.NO_INDUK_SISWA '+
                     'AND A.ID_JADWAL=C.ID_JADWAL '+
                     'AND C.ID_MAPEL_AMPU=D.ID_MAPEL_AMPU '+
                     'AND D.ID_MAPEL=E.ID_MAPEL '+
                     'AND D.NO_INDUK_PEGAWAI=F.NO_INDUK_PEGAWAI '+
                     'AND B.ID_KELAS=G.ID_KELAS AND B.ID_JURUSAN=H.ID_JURUSAN '+
                     query_tambahan;
         Open;
        end;

       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'/FReport/fr_riwayat.fr3');
       isi_header;
       frxReport1.Variables.Variables['JUDUL'] := '''' + 'LAPORAN PENGGUNAAN LABORATORIUM KOMPUTER' + '''';
       frxReport1.ShowReport();
      end;
 end;
end;

procedure Tf_laporan.cbLaporanKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key) 
end;

end.
