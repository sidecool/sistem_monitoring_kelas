unit u_siswa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  Tf_siswa = class(TForm)
    GroupBox1: TGroupBox;
    lbJenisKelamin: TLabel;
    lbTglLahir: TLabel;
    lbAgama: TLabel;
    Panel1: TPanel;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnTutup: TBitBtn;
    edKode: TLabeledEdit;
    edNama: TLabeledEdit;
    cbJenisKelamin: TComboBox;
    edTempatLahir: TLabeledEdit;
    cbAgama: TComboBox;
    edAlamat: TLabeledEdit;
    edTelp: TLabeledEdit;
    DTPTglLahir: TDateTimePicker;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    lbKelas: TLabel;
    cbKelas: TComboBox;
    cbJurusan: TComboBox;
    lbJurusan: TLabel;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edKodeKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimpanClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure edKodeExit(Sender: TObject);
    procedure cbJurusanChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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
  f_siswa: Tf_siswa;

implementation

uses u_dm, DateUtils, DB, u_server;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_siswa.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_siswa.btnTutupClick(Sender: TObject);
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

procedure form_default;
begin
 with f_siswa do
  begin
   edNama.Clear;
   cbJenisKelamin.ItemIndex := 0;
   edTempatLahir.Clear;
   DTPTglLahir.Date := Now;
   cbAgama.ItemIndex := 0;
   edAlamat.Clear;
   edTelp.Clear;
  end;
end;

procedure form_isi(kelas, jurusan: String);
var
 JK: String;
begin
 with f_siswa do
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM T_SISWA WHERE NO_INDUK_SISWA='+#39+edKode.Text+#39+
                  ' AND ID_KELAS='+#39+kelas+#39+' AND ID_JURUSAN='+#39+jurusan+#39;
      Open;

      if FieldByName('NO_INDUK_SISWA').AsString <> '' then
       begin
        if FieldByName('JENIS_KELAMIN').AsString = 'L' then
         JK := 'Laki-laki'
        else if FieldByName('JENIS_KELAMIN').AsString = 'P' then
         JK := 'Perempuan';

        edNama.Text              := FieldByName('NM_SISWA').AsString;
        cbJenisKelamin.ItemIndex := cbJenisKelamin.Items.IndexOf(JK);
        edTempatLahir.Text       := FieldByName('TEMPAT_LAHIR').AsString;
        DTPTglLahir.Date         := FieldByName('TGL_LAHIR').AsDateTime;
        cbAgama.ItemIndex        := cbAgama.Items.IndexOf(FieldByName('AGAMA').AsString);
        edAlamat.Text            := FieldByName('ALAMAT').AsString;
        edTelp.Text              := FieldByName('NO_TELP').AsString;
        cbKelas.ItemIndex        := ComboIndex(cbKelas, FieldByName('ID_KELAS').AsString);
        cbJurusan.ItemIndex      := ComboIndex(cbJurusan, FieldByName('ID_JURUSAN').AsString);

        btnHapus.Enabled := True;
       end
      else
       begin
        form_default;
        btnHapus.Enabled := False;
       end;
     end;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure tampil_kelas;
begin
 with f_siswa do
  begin
   try
    cbKelas.Clear;
    cbKelas.Items.AddObject('- Pilih Kelas', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT ID_KELAS AS KODE, NM_KELAS AS NAMA FROM T_KELAS ORDER BY NM_KELAS';
      Open;

      while not DMServer.ZQEksekusi2.Eof do
       begin
        cbKelas.Items.AddObject(FieldByName('NAMA').AsString, TString_.Create(FieldByName('KODE').AsString));
        Next;
       end;
     end;
    cbKelas.ItemIndex := 0;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure tampil_jurusan;
begin
 with f_siswa do
  begin
   try
    cbJurusan.Clear;
    cbJurusan.Items.AddObject('- Pilih Jurusan', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT ID_JURUSAN AS KODE, NM_JURUSAN AS NAMA FROM T_JURUSAN ORDER BY NM_JURUSAN';
      Open;

      while not DMServer.ZQEksekusi2.Eof do
       begin
        cbJurusan.Items.AddObject(FieldByName('NAMA').AsString, TString_.Create(FieldByName('KODE').AsString));
        Next;
       end;
     end;
    cbJurusan.ItemIndex := 0;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end; 
  end;
end;

procedure tampil_grid(kelas, jurusan: String);
begin
 if (kelas<>'') and (jurusan<>'') then
  begin
   try
    with DMServer.ZQTampil1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT a.NO_INDUK_SISWA AS KODE, a.NM_SISWA AS NAMA, a.TEMPAT_LAHIR, '+
                  'DATE_FORMAT(a.TGL_LAHIR, "%e/%m/%Y") AS TGL_LAHIR, '+
                  'CONCAT(a.TEMPAT_LAHIR,'+#39+', '+#39+',DATE_FORMAT(a.TGL_LAHIR, "%e/%m/%Y")) AS TTL, '+
                  'a.JENIS_KELAMIN, a.AGAMA, a.NO_TELP, SUBSTRING(a.ALAMAT, 1, 5000) AS ALAMAT, '+
                  'a.ID_KELAS, b.NM_KELAS, a.ID_JURUSAN, c.NM_JURUSAN '+
                  'FROM T_SISWA AS a, T_KELAS AS b, T_JURUSAN AS c '+
                  'WHERE a.ID_KELAS=b.ID_KELAS AND a.ID_JURUSAN=c.ID_JURUSAN AND '+
                  'a.ID_KELAS='+#39+kelas+#39+' AND a.ID_JURUSAN='+#39+jurusan+#39+' ORDER BY NM_SISWA';
      Open;
     end;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_siswa.FormShow(Sender: TObject);
begin
 DMServer.ZQTampil1.SQL.Clear;
 btnHapus.Enabled := False;
 form_default;
 tampil_kelas;
 tampil_jurusan;
 cbKelas.SetFocus;
end;

procedure Tf_siswa.edKodeKeyPress(Sender: TObject; var Key: Char);
begin
 if (Sender=edKode) or (Sender=edTelp) then
  begin
   if not(Key in['0'..'9', #8, #13]) then
    key:= #0 ;
  end;

 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_siswa.btnSimpanClick(Sender: TObject);
var
 JK: String;
 TNow, TLhr, TSelisih: Integer;
begin
 if cbJenisKelamin.ItemIndex=1 then
  JK := 'L'
 else if cbJenisKelamin.ItemIndex=2 then
  JK := 'P';

 TNow     := YearOf(Now);
 TLhr     := YearOf(DTPTglLahir.Date);
 TSelisih := TNow-TLhr;

 if edKode.Text = '' then
  begin
   MessageDlg(edKode.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKode.SetFocus;
  end
 else if edNama.Text = '' then
  begin
   MessageDlg(edNama.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edNama.SetFocus;
  end
 else if cbJenisKelamin.ItemIndex < 1 then
  begin
   MessageDlg(lbJenisKelamin.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbJenisKelamin.SetFocus;
  end
 else if cbAgama.ItemIndex < 1 then
  begin
   MessageDlg(lbAgama.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbAgama.SetFocus;
  end
 else if cbKelas.ItemIndex < 1 then
  begin
   MessageDlg(lbKelas.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbKelas.SetFocus;
  end
 else if cbJurusan.ItemIndex < 1 then
  begin
   MessageDlg(lbJurusan.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbJurusan.SetFocus;
  end
 else if (TSelisih < 12) or (TSelisih > 20) then
  begin
   MessageDlg(lbTglLahir.Caption+' salah memilih tahun, siswa minimal berusia 12 dan atau maksimal 20', mtWarning, [mbOK], 0);
   DTPTglLahir.SetFocus;
  end
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      if btnHapus.Enabled then
       SQL.Text := 'UPDATE T_SISWA SET NM_SISWA='+#39+edNama.Text+#39+','+
                   ' TEMPAT_LAHIR='+#39+edTempatLahir.Text+#39+','+
                   ' TGL_LAHIR=STR_TO_DATE('+#39+DateToStr(DTPTglLahir.Date, f_server.fs)+#39+', "%e/%m/%Y")'+','+
                   ' JENIS_KELAMIN='+#39+JK+#39+','+
                   ' AGAMA='+#39+cbAgama.Text+#39+','+
                   ' NO_TELP='+#39+edTelp.Text+#39+','+
                   ' ALAMAT='+#39+edAlamat.Text+#39+','+
                   ' ID_KELAS='+#39+TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str+#39+','+
                   ' ID_JURUSAN='+#39+TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str+#39+
                   ' WHERE NO_INDUK_SISWA='+#39+edKode.Text+#39
      else
       SQL.Text := 'INSERT INTO T_SISWA VALUES ('+#39+edKode.Text+#39+','+
                                                  #39+edNama.Text+#39+','+
                                                  #39+edTempatLahir.Text+#39+','+
                                                  'STR_TO_DATE('+#39+DateToStr(DTPTglLahir.Date, f_server.fs)+#39+', "%e/%m/%Y"),'+
                                                  #39+JK+#39+','+
                                                  #39+cbAgama.Text+#39+','+
                                                  #39+edTelp.Text+#39+','+
                                                  #39+edAlamat.Text+#39+','+
                                                  #39+TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str+#39+','+
                                                  #39+TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str+#39+')';
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edKode.Clear;
    form_default;
    edKode.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_siswa.DBGrid1DblClick(Sender: TObject);
begin
 edKode.Text := DBGrid1.Fields[0].AsString;
 form_isi(TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str,
          TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str);
end;

procedure Tf_siswa.btnHapusClick(Sender: TObject);
begin
 if edKode.Text = '' then
  begin
   MessageDlg(edKode.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKode.SetFocus;
  end
 else if edNama.Text = '' then
  begin
   MessageDlg(edNama.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edNama.SetFocus;
  end
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM T_SISWA WHERE NO_INDUK_SISWA='+#39+edKode.Text+#39;
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edKode.Clear;
    form_default;
    edKode.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_siswa.edKodeExit(Sender: TObject);
begin
 form_isi(TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str,
          TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str);
end;


procedure Tf_siswa.cbJurusanChange(Sender: TObject);
begin
 tampil_grid(TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str,
             TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str);
end;

end.
