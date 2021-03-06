unit u_login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  Tf_login = class(TForm)
    edUser: TLabeledEdit;
    edPass: TLabeledEdit;
    btnLogin: TBitBtn;
    btnBatal: TBitBtn;
    procedure btnBatalClick(Sender: TObject);
    procedure edUserKeyPress(Sender: TObject; var Key: Char);
    procedure edPassKeyPress(Sender: TObject; var Key: Char);
    procedure btnLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_login: Tf_login;

implementation

uses u_server, u_dm, DB, u_kelas_lab;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_login.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_login.btnBatalClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_login.edUserKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_login.edPassKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  btnLogin.Click;
end;

procedure Tf_login.btnLoginClick(Sender: TObject);
begin
 if edUser.Text = '' then
  begin
   MessageDlg(edUser.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edUser.SetFocus;
  end
 else if edPass.Text = '' then
  begin
   MessageDlg(edPass.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edPass.SetFocus;
  end
 else
  begin
   //jika login berhasil
   with DMServer do
    begin
     USERNAME := '-';
     NIP      := '-';
     NAMA     := '-';

     with ZQEksekusi1 do
      begin
       Close;
       SQL.Clear;
       SQL.Text := 'SELECT A.*, B.NM_GURU FROM T_USER A, T_GURU B '+
                   'WHERE USERNAME='+#39+edUser.Text+#39+' AND A.NO_INDUK_PEGAWAI=B.NO_INDUK_PEGAWAI';
       Open;

       if FieldByName('USERNAME').AsString = '' then
        begin
         MessageDlg(edUser.EditLabel.Caption+' tidak ditemukan', mtWarning, [mbOK], 0);
         edUser.SetFocus;
        end
       else if FieldByName('PASSWORD').AsString <> edPass.Text then
        begin
         MessageDlg(edPass.EditLabel.Caption+' salah', mtWarning, [mbOK], 0);
         edPass.SetFocus;
        end
       else
        begin
         with f_server do
          begin
           if FieldByName('USERNAME').AsString = 'MYADMIN' then
            begin
             DataUser1.Visible      := True;
             MasterData1.Visible    := True;
            end;
           GantiPassword1.Visible := True;
           Laporan1.Visible       := True;

           btnViewReport.Enabled := True;
           btnViewIcon.Enabled   := True;
           btnViewSimpan.Enabled := True;

           Login1.Caption         := '&Logout';

           USERNAME := FieldByName('USERNAME').AsString;
           NIP      := FieldByName('NO_INDUK_PEGAWAI').AsString;
           NAMA     := FieldByName('NM_GURU').AsString;
          end;
         f_login.Close;
        end;
      end;
    end;
  end;
end;

procedure Tf_login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (DMServer.USERNAME<>'MYADMIN') and (DMServer.USERNAME<>'-') then
  begin
   try
    f_kelas_lab := Tf_kelas_lab.Create(Self);
    f_kelas_lab.ShowModal;
   except
    f_kelas_lab.Free;
   end;
  end;
end;

end.
