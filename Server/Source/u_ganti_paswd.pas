unit u_ganti_paswd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  Tf_ganti_paswd = class(TForm)
    edPassLama: TLabeledEdit;
    edPassBaru: TLabeledEdit;
    edPassKonf: TLabeledEdit;
    btnSimpan: TBitBtn;
    btnTutup: TBitBtn;
    procedure btnTutupClick(Sender: TObject);
    procedure edPassLamaKeyPress(Sender: TObject; var Key: Char);
    procedure edPassKonfExit(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure edPassLamaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_ganti_paswd: Tf_ganti_paswd;

implementation

uses u_dm, DB, u_server;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_ganti_paswd.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_ganti_paswd.btnTutupClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_ganti_paswd.edPassLamaKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_ganti_paswd.edPassKonfExit(Sender: TObject);
begin
 if edPassKonf.Text <> edPassBaru.Text then
  begin
   MessageDlg(edPassKonf.EditLabel.Caption+' tidak sama dengan '+edPassBaru.EditLabel.Caption, mtWarning, [mbOK], 0);
   edPassKonf.SetFocus;
  end;
end;

procedure Tf_ganti_paswd.btnSimpanClick(Sender: TObject);
begin
 if edPassLama.Text = '' then
  begin
   MessageDlg(edPassLama.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edPassLama.SetFocus;
  end
 else if edPassBaru.Text = '' then
  begin
   MessageDlg(edPassBaru.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edPassBaru.SetFocus;
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
      SQL.Text := 'SELECT PASSWORD FROM T_USER '+
                  'WHERE USERNAME='+#39+DMServer.USERNAME+#39;
      Open;

      if FieldByName('PASSWORD').AsString=edPassLama.Text then
       MessageDlg('Peringatan: Password lama tidak sesuai.', mtWarning, [mbOK], 0)
      else
       begin
        Close;
        SQL.Clear;
        SQL.Text := 'UPDATE T_USER SET PASSWORD='+#39+edPassKonf.Text+#39+
                    ' WHERE USERNAME='+#39+DMServer.USERNAME+#39+' AND '+
                    'PASSWORD='+#39+edPassLama.Text+#39;
        ExecSQL;

        ShowMessage('Password berhasil diubah, silahkan Anda login ulang.');
        f_server.Login1.Click; // Merubah Caption Logout menjadi Login
        f_server.Login1.Click; // Menampilkan Form Login
       end;
     end;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
   Close;
  end;
end;

procedure Tf_ganti_paswd.edPassLamaExit(Sender: TObject);
begin
 try
  with DMServer.ZQEksekusi2 do
   begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT PASSWORD FROM T_USER '+
                'WHERE USERNAME='+#39+DMServer.USERNAME+#39;
    Open;

    if FieldByName('PASSWORD').AsString = '' then
     begin
      ShowMessage('Password lama salah, silahkan ulangi lagi.');
      edPassLama.SetFocus;
     end; 
   end;
 except
  on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
 end;
end;

end.
