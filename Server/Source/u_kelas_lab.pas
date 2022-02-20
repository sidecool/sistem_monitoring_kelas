unit u_kelas_lab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tf_kelas_lab = class(TForm)
    cbKelas: TComboBox;
    cbJurusan: TComboBox;
    cbMapel: TComboBox;
    lbKelas: TLabel;
    lbJurusan: TLabel;
    lbMapel: TLabel;
    btnMasuk: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure cbKelasKeyPress(Sender: TObject; var Key: Char);
    procedure cbMapelChange(Sender: TObject);
    procedure btnMasukClick(Sender: TObject);
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
  f_kelas_lab: Tf_kelas_lab;

implementation

uses u_dm, DB;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_kelas_lab.Perform(WM_NEXTDLGCTL,0,0);
  end;
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

procedure tampil_lab;
var
 GABUNG: String;
begin
 {GABUNG := DMServer.NIP+'.'+DMServer.ID_KELAS+'.'+DMServer.ID_JURUSAN+'.'+
           DMServer.ID_MAPEL;

 with f_kelas_lab do
  begin
   try
    DMServer.ID_LAB := '-';
    DMServer.LAB    := '-';

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT A.ID_LAB AS KODE, A.NM_LAB AS NAMA '+
                  'FROM T_LAB A, T_JADWAL_LAB B '+
                  'WHERE B.ID_MAPEL_AMPU='+#39+GABUNG+#39+' AND '+
                  'A.ID_LAB=B.ID_LAB '+
                  'ORDER BY NM_LAB';
      Open;

      if FieldByName('NAMA').AsString <> '' then
       begin
        DMServer.ID_LAB := FieldByName('KODE').AsString;
        DMServer.LAB    := FieldByName('NAMA').AsString;
       end;
     end;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;}
end;

procedure tampil_kelas;
begin
 with f_kelas_lab do
  begin
   try
    cbKelas.Clear;
    cbKelas.Items.AddObject('- Pilih Kelas', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT A.ID_KELAS AS KODE, A.NM_KELAS AS NAMA '+
                  'FROM T_KELAS A, T_MAPEL_AMPU B '+
                  'WHERE B.NO_INDUK_PEGAWAI='+#39+DMServer.NIP+#39+' AND '+
                  'A.ID_KELAS=B.ID_KELAS '+
                  'ORDER BY NM_KELAS';
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
 with f_kelas_lab do
  begin
   try
    cbJurusan.Clear;
    cbJurusan.Items.AddObject('- Pilih Jurusan', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT A.ID_JURUSAN AS KODE, A.NM_JURUSAN AS NAMA '+
                  'FROM T_JURUSAN A, T_MAPEL_AMPU B '+
                  'WHERE B.NO_INDUK_PEGAWAI='+#39+DMServer.NIP+#39+' AND '+
                  'A.ID_JURUSAN=B.ID_JURUSAN '+
                  'ORDER BY NM_JURUSAN';
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

procedure tampil_mapel;
begin
 with f_kelas_lab do
  begin
   try
    cbMapel.Clear;
    cbMapel.Items.AddObject('- Pilih Mata Pelajaran', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT A.ID_MAPEL AS KODE, A.NM_MAPEL AS NAMA '+
                  'FROM T_MAPEL A, T_MAPEL_AMPU B '+
                  'WHERE B.NO_INDUK_PEGAWAI='+#39+DMServer.NIP+#39+' AND '+
                  'A.ID_MAPEL=B.ID_MAPEL '+
                  'ORDER BY NM_MAPEL';
      Open;

      while not DMServer.ZQEksekusi2.Eof do
       begin
        cbMapel.Items.AddObject(FieldByName('NAMA').AsString, TString_.Create(FieldByName('KODE').AsString));
        Next;
       end;
     end;
    cbMapel.ItemIndex := 0;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_kelas_lab.FormShow(Sender: TObject);
begin
 tampil_kelas;
 tampil_jurusan;
 tampil_mapel;
 cbKelas.SetFocus;
end;

procedure Tf_kelas_lab.cbKelasKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_kelas_lab.cbMapelChange(Sender: TObject);
begin
 if cbMapel.ItemIndex > 0 then
  btnMasuk.Enabled := True
 else
  btnMasuk.Enabled := False
end;

procedure Tf_kelas_lab.btnMasukClick(Sender: TObject);
begin
 DMServer.ID_KELAS   := '-';
 DMServer.ID_JURUSAN := '-';
 DMServer.ID_MAPEL   := '-';

 DMServer.KELAS   := '-';
 DMServer.JURUSAN := '-';
 DMServer.MAPEL   := '-';

 if cbKelas.ItemIndex < 1 then
  begin
   cbKelas.SetFocus;
  end
 else if cbJurusan.ItemIndex < 1 then
  begin
   cbJurusan.SetFocus;
  end
 else if cbMapel.ItemIndex < 1 then
  begin
   cbMapel.SetFocus;
  end
 else
  begin
   DMServer.ID_KELAS   := TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str;
   DMServer.ID_JURUSAN := TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str;
   DMServer.ID_MAPEL   := TString_(cbMapel.Items.Objects[cbMapel.ItemIndex]).Str;

   DMServer.KELAS   := cbKelas.Text;
   DMServer.JURUSAN := cbJurusan.Text;
   DMServer.MAPEL   := cbMapel.Text;

   with DMServer.ZQEksekusi2 do
    begin
     Close;
     SQL.Clear;
     SQL.Text := 'SELECT ID_JADWAL FROM T_JADWAL_LAB '+
                 'WHERE ID_LAB='+#39+DMServer.ID_LAB+#39+' AND '+
                 'ID_MAPEL_AMPU='+#39+DMServer.NIP+'.'+DMServer.ID_KELAS+'.'+
                                      DMServer.ID_JURUSAN+'.'+
                                      DMServer.ID_MAPEL+#39+' AND '+
                 'TAHUN_AJAR='+#39+FormatDateTime('yyyy', Now)+#39;
     Open;

     if FieldByName('ID_JADWAL').AsString <> '' then
      begin
       DMServer.ID_JADWAL := FieldByName('ID_JADWAL').AsString;
       f_kelas_lab.Close;
      end
     else
      begin
       DMServer.ID_JADWAL := '';
       MessageDlg('Peringatan : Hari ini tidak ada jadwal penggunaan lab '+
                  'untuk mata pelajaran dan kelas ini.', mtWarning, [mbOK], 0);
      end;
    end;
  end;
end;

end.
