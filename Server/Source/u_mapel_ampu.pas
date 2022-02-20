unit u_mapel_ampu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  Tf_mapel_ampu = class(TForm)
    GroupBox1: TGroupBox;
    lbGuru: TLabel;
    Panel1: TPanel;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnTutup: TBitBtn;
    cbGuru: TComboBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    cbMapel: TComboBox;
    lbMapel: TLabel;
    cbKelas: TComboBox;
    cbJurusan: TComboBox;
    lbJurusan: TLabel;
    lbKelas: TLabel;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbGuruChange(Sender: TObject);
    procedure cbGuruKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimpanClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
  private
    { Private declarations }

    ID_MAPEL_AMPU, ID_MAPEL_AMPU_LAMA: String;
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
  f_mapel_ampu: Tf_mapel_ampu;

implementation

uses u_dm, DateUtils, DB;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_mapel_ampu.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_mapel_ampu.btnTutupClick(Sender: TObject);
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
 with f_mapel_ampu do
  begin
   ID_MAPEL_AMPU_LAMA  := '';
   ID_MAPEL_AMPU       := '';
   //cbGuru.ItemIndex    := 0;
   cbKelas.ItemIndex   := 0;
   cbJurusan.ItemIndex := 0;
   cbMapel.ItemIndex   := 0;
  end;
end;

procedure form_isi(kode: String);
begin
 with f_mapel_ampu do
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM T_MAPEL_AMPU WHERE ID_MAPEL_AMPU='+#39+kode+#39;
      Open;

      ID_MAPEL_AMPU_LAMA := '';
      if FieldByName('ID_MAPEL_AMPU').AsString <> '' then
       begin
        ID_MAPEL_AMPU_LAMA  := FieldByName('ID_MAPEL_AMPU').AsString;
        cbGuru.ItemIndex    := ComboIndex(cbGuru, FieldByName('NO_INDUK_PEGAWAI').AsString);
        cbKelas.ItemIndex   := ComboIndex(cbKelas, FieldByName('ID_KELAS').AsString);
        cbJurusan.ItemIndex := ComboIndex(cbJurusan, FieldByName('ID_JURUSAN').AsString);
        cbMapel.ItemIndex   := ComboIndex(cbMapel, FieldByName('ID_MAPEL').AsString);

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

procedure tampil_guru;
begin
 with f_mapel_ampu do
  begin
   try
    cbGuru.Clear;
    cbGuru.Items.AddObject('- Pilih Guru', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT NO_INDUK_PEGAWAI AS KODE, NM_GURU AS NAMA '+
                  'FROM T_GURU WHERE NO_INDUK_PEGAWAI <> ''XXX99AAA'' ORDER BY NM_GURU';
      Open;

      while not DMServer.ZQEksekusi2.Eof do
       begin
        cbGuru.Items.AddObject(FieldByName('NAMA').AsString, TString_.Create(FieldByName('KODE').AsString));
        Next;
       end;
     end;
    cbGuru.ItemIndex := 0;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure tampil_kelas;
begin
 with f_mapel_ampu do
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
 with f_mapel_ampu do
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

procedure tampil_mapel;
begin
 with f_mapel_ampu do
  begin
   try
    cbMapel.Clear;
    cbMapel.Items.AddObject('- Pilih Mata Pelajaran', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT ID_MAPEL AS KODE, NM_MAPEL AS NAMA FROM T_MAPEL ORDER BY NM_MAPEL';
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

procedure tampil_grid(guru: String);
begin
 if (guru<>'') then
  begin
   try
    with DMServer.ZQTampil1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT A.ID_MAPEL_AMPU AS KODE, A.NO_INDUK_PEGAWAI, B.NM_GURU, '+
                  'A.ID_KELAS, C.NM_KELAS, A.ID_JURUSAN, D.NM_JURUSAN, A.ID_MAPEL, '+
                  'E.NM_MAPEL, CONCAT_WS('', '',C.NM_KELAS,A.ID_JURUSAN) AS KELAS_JURUSAN '+
                  'FROM T_MAPEL_AMPU A, T_GURU B, T_KELAS C, T_JURUSAN D, T_MAPEL E '+
                  'WHERE A.NO_INDUK_PEGAWAI='+#39+guru+#39+' AND A.NO_INDUK_PEGAWAI=B.NO_INDUK_PEGAWAI '+
                  'AND A.ID_KELAS=C.ID_KELAS AND A.ID_JURUSAN=D.ID_JURUSAN AND A.ID_MAPEL=E.ID_MAPEL';
      Open;
     end;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_mapel_ampu.FormShow(Sender: TObject);
begin
 DMServer.ZQTampil1.SQL.Clear;
 btnHapus.Enabled := False;
 form_default;
 tampil_guru;
 tampil_kelas;
 tampil_jurusan;
 tampil_mapel;
 cbGuru.SetFocus;
end;

procedure Tf_mapel_ampu.cbGuruChange(Sender: TObject);
begin
 tampil_grid(TString_(cbGuru.Items.Objects[cbGuru.ItemIndex]).Str);
end;

procedure Tf_mapel_ampu.cbGuruKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_mapel_ampu.btnSimpanClick(Sender: TObject);
begin
 if cbGuru.ItemIndex < 1 then
  begin
   MessageDlg(lbGuru.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbGuru.SetFocus;
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
 else if cbMapel.ItemIndex < 1 then
  begin
   MessageDlg(lbMapel.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbMapel.SetFocus;
  end
 else
  begin
   try
    ID_MAPEL_AMPU := TString_(cbGuru.Items.Objects[cbGuru.ItemIndex]).Str+'.'+
                     TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str+'.'+
                     TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str+'.'+
                     TString_(cbMapel.Items.Objects[cbMapel.ItemIndex]).Str;

    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      if btnHapus.Enabled then
       SQL.Text := 'UPDATE T_MAPEL_AMPU SET ID_MAPEL_AMPU='+#39+ID_MAPEL_AMPU+#39+','+
                   ' ID_MAPEL='+#39+TString_(cbMapel.Items.Objects[cbMapel.ItemIndex]).Str+#39+','+
                   ' NO_INDUK_PEGAWAI='+#39+TString_(cbGuru.Items.Objects[cbGuru.ItemIndex]).Str+#39+','+
                   ' ID_KELAS='+#39+TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str+#39+','+
                   ' ID_JURUSAN='+#39+TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str+#39+
                   ' WHERE ID_MAPEL_AMPU='+#39+ID_MAPEL_AMPU_LAMA+#39
      else
       SQL.Text := 'INSERT INTO T_MAPEL_AMPU VALUES ('+#39+ID_MAPEL_AMPU+#39+','+
                                                       #39+TString_(cbMapel.Items.Objects[cbMapel.ItemIndex]).Str+#39+','+
                                                       #39+TString_(cbGuru.Items.Objects[cbGuru.ItemIndex]).Str+#39+','+
                                                       #39+TString_(cbKelas.Items.Objects[cbKelas.ItemIndex]).Str+#39+','+
                                                       #39+TString_(cbJurusan.Items.Objects[cbJurusan.ItemIndex]).Str+#39+')';
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    form_default;
    cbGuru.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_mapel_ampu.DBGrid1DblClick(Sender: TObject);
begin
 form_isi(DBGrid1.Fields[0].AsString);
end;

procedure Tf_mapel_ampu.btnHapusClick(Sender: TObject);
begin
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM T_MAPEL_AMPU WHERE ID_MAPEL_AMPU='+#39+ID_MAPEL_AMPU+#39;
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    form_default;
    cbGuru.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

end.
