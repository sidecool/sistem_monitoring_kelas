unit u_pengaturan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, INIFiles;

type
  Tf_pengaturan = class(TForm)
    edHost: TLabeledEdit;
    edPort: TLabeledEdit;
    edUser: TLabeledEdit;
    edPass: TLabeledEdit;
    edDatabase: TLabeledEdit;
    btnConnect: TBitBtn;
    lbStatus: TLabel;
    btnSimpan: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edHostKeyPress(Sender: TObject; var Key: Char);
    procedure btnConnectClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cari: String;
    FileINI: TIniFile;
  public
    { Public declarations }
  end;

var
  f_pengaturan: Tf_pengaturan;

implementation

uses u_dm, ZConnection, u_server;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_pengaturan.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

function keyangka(var Key: Char): Boolean;
begin
 if not(Key in ['0'..'9',#8,#13,#32,#27]) then
  begin
   Key := #0;
   MessageDlg('Inputan hanya boleh angka.', mtError, [mbOK], 0);
   Result := False;
  end;
end;

procedure Tf_pengaturan.FormShow(Sender: TObject);
begin
 cari := '';
 cari := FileSearch('config.ini', GetCurrentDir);

 FileINI := TIniFile.Create(GetCurrentDir+'\config.ini');
 if cari='' then
  begin
   MessageDlg('Error: file config.ini tidak ditemukan', mtError, [mbOK], 0);
  end
 else
  begin
   edHost.Text     := FileINI.ReadString('DATABASE','host','');
   edPort.Text     := FileINI.ReadString('DATABASE','port','');
   edUser.Text     := FileINI.ReadString('DATABASE','user','');
   edPass.Text     := FileINI.ReadString('DATABASE','pass','');
   edDatabase.Text := FileINI.ReadString('DATABASE','database','');
  end;
 FileINI.Free;

 edHost.SetFocus;
end;

procedure Tf_pengaturan.edHostKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
 else if (Sender = edPort) and (not(keyangka(Key))) then Abort
end;

procedure Tf_pengaturan.btnConnectClick(Sender: TObject);
begin
 if edHost.Text = '' then
  begin
   MessageDlg('Kolom Server Host tidak boleh kosong.',mtWarning,[mbOK],0);
   edHost.SetFocus;
  end
 else if edPort.Text = '' then
  begin
   MessageDlg('Kolom Server Port tidak boleh kosong.',mtWarning,[mbOK],0);
   edPort.SetFocus;
  end
 else if edUser.Text = '' then
  begin
   MessageDlg('Kolom User tidak boleh kosong, isikan root untuk pengaturan bawaan.',mtWarning,[mbOK],0);
   edUser.SetFocus;
  end
 else if edDatabase.Text = '' then
  begin
   MessageDlg('Kolom Database tidak boleh kosong, isikan sesuai nama database.',mtWarning,[mbOK],0);
   edDatabase.SetFocus;
  end
 else
  begin
   with DMServer.ZConnection1 do
    begin
     try
      Connected := False;

      Database := edDatabase.Text;
      HostName := edHost.Text;
      Port     := StrToInt(edPort.Text);
      User     := edUser.Text;
      Password := edPass.Text;

      Connected := True;
     except
      on e: Exception do MessageDlg('Error: '+e.Message,mtError,[mbOK],0)
     end;

     if Connected=True then
      begin
       btnSimpan.Visible := True;
       lbStatus.Caption := 'Status : Database terhubung';
       f_server.StatusBar1.Panels[1].Text := 'Database : Terhubung';
      end
     else if Connected=False then
      begin
       btnSimpan.Visible := False;
       lbStatus.Caption := 'Status : Database gagal terhubung';
       f_server.StatusBar1.Panels[1].Text := 'Database : Gagal Terhubung';
      end;
    end;
  end;
end;

procedure Tf_pengaturan.btnSimpanClick(Sender: TObject);
begin
 try
  begin
   FileINI := TIniFile.Create(GetCurrentDir+'\config.ini');
   FileINI.WriteString('DATABASE','host',edHost.Text);
   FileINI.WriteString('DATABASE','port',edPort.Text);
   FileINI.WriteString('DATABASE','user',edUser.Text);
   FileINI.WriteString('DATABASE','password',edPass.Text);
   FileINI.WriteString('DATABASE','database',edDatabase.Text);
   FileINI.Free;

   ShowMessage('Berhasil menyimpan config.ini');
   Close;
  end
 except
  on e: Exception do MessageDlg('Error: '+e.Message,mtError,[mbOK],0)
 end;
end;

procedure Tf_pengaturan.FormCreate(Sender: TObject);
begin
 Position := poDesktopCenter;
end;

end.
