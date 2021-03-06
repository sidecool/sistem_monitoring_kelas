unit u_user;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, ComCtrls;

type
  Tf_user = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnTutup: TBitBtn;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    edUser: TLabeledEdit;
    edPass: TLabeledEdit;
    cbGuru: TComboBox;
    edPassKonf: TLabeledEdit;
    lbGuru: TLabel;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edUserKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimpanClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure edUserExit(Sender: TObject);
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
  f_user: Tf_user;

implementation

uses u_dm, DateUtils;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_user.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_user.btnTutupClick(Sender: TObject);
begin
 Close;
end;

constructor TString_.Create(const AStr: String);
begin
 inherited Create;
 FStr := AStr;
end;

procedure form_default;
begin
 with f_user do
  begin
   cbGuru.ItemIndex := 0;
   edPass.Clear;
   edPassKonf.Clear;
  end;
end;

procedure form_isi;
begin
 with f_user do
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM T_USER WHERE USERNAME='+#39+edUser.Text+#39;
      Open;

      if FieldByName('NO_INDUK_PEGAWAI').AsString <> '' then
       begin
        cbGuru.ItemIndex := 0;
        edPass.Text      := FieldByName('PASSWORD').AsString;

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
 with f_user do
  begin
   try
    cbGuru.Clear;
    cbGuru.Items.AddObject('- Pilih Data Pegawai', TString_.Create('-'));

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

procedure Tf_user.FormShow(Sender: TObject);
begin
 btnHapus.Enabled := False;
 form_default;
 tampil_guru;

 with DMServer.ZQTampil1 do
  begin
   Close;
   SQL.Clear;
   SQL.Text := 'SELECT A.*, B.NM_GURU FROM T_USER A, T_GURU B WHERE A.NO_INDUK_PEGAWAI=B.NO_INDUK_PEGAWAI';
   Open;
  end;
 edUser.SetFocus;
end;

procedure Tf_user.edUserKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_user.btnSimpanClick(Sender: TObject);
begin
 if edUser.Text = '' then
  begin
   MessageDlg(edUser.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edUser.SetFocus;
  end
 else if edPassKonf.Text = '' then
  begin
   MessageDlg(edPassKonf.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edPassKonf.SetFocus;
  end
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      if btnHapus.Enabled then
       SQL.Text := 'UPDATE T_USER SET NO_INDUK_PEGAWAI='+#39+TString_(cbGuru.Items.Objects[cbGuru.ItemIndex]).Str+#39+','+
                   'PASSWORD='+#39+edPassKonf.Text+#39+' WHERE USERNAME='+#39+edUser.Text+#39
      else
       SQL.Text := 'INSERT INTO T_USER VALUES ('+#39+edUser.Text+#39+','+
                                                 #39+TString_(cbGuru.Items.Objects[cbGuru.ItemIndex]).Str+#39+','+
                                                 #39+edPassKonf.Text+#39+')';
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edUser.Clear;
    form_default;
    edUser.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_user.DBGrid1DblClick(Sender: TObject);
begin
 edUser.Text := DBGrid1.Fields[1].AsString;
 form_isi;
end;

procedure Tf_user.btnHapusClick(Sender: TObject);
begin
 if edUser.Text = '' then
  begin
   MessageDlg(edUser.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edUser.SetFocus;
  end
 else if edPassKonf.Text = '' then
  begin
   MessageDlg(edPassKonf.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edPassKonf.SetFocus;
  end
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM T_USER WHERE USERNAME='+#39+edUser.Text+#39;
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edUser.Clear;
    form_default;
    edUser.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_user.edUserExit(Sender: TObject);
begin
 form_isi;
end;

end.
