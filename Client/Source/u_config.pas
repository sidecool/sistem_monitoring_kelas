unit u_config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, INIFiles;

type
  Tf_config = class(TForm)
    edNomor: TLabeledEdit;
    edServer: TLabeledEdit;
    edLocal: TLabeledEdit;
    btnSimpan: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edNomorKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cari: String;
    FileINI: TIniFile;
  public
    { Public declarations }
    KOMPUTER,SERVER,LOCAL: String;
  end;

var
  f_config: Tf_config;

implementation

uses u_client;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_config.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_config.FormShow(Sender: TObject);
begin
 cari := '';
 cari := FileSearch('SetClient.ini', GetCurrentDir);

 FileINI := TIniFile.Create(GetCurrentDir+'\SetClient.ini');
 if cari='' then
  begin
   MessageDlg('Error: file SetClient.ini tidak ditemukan', mtError, [mbOK], 0);
  end
 else
  begin
   edNomor.Text  := FileINI.ReadString('KOMPUTER','IDKomputer','');
   edServer.Text := FileINI.ReadString('KOMPUTER','ServerHost','');
   edLocal.Text  := FileINI.ReadString('KOMPUTER','LocalAddress','');
  end;
 FileINI.Free;

 edNomor.SetFocus;
end;

procedure Tf_config.edNomorKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_config.btnSimpanClick(Sender: TObject);
begin
 try
  begin
   FileINI := TIniFile.Create(GetCurrentDir+'\SetClient.ini');
   FileINI.WriteString('KOMPUTER','IDKomputer',edNomor.Text);
   FileINI.WriteString('KOMPUTER','ServerHost',edServer.Text);
   FileINI.WriteString('KOMPUTER','LocalAddress',edLocal.Text);
   FileINI.Free;

   ShowMessage('Berhasil menyimpan SetClient.ini');
   KOMPUTER := edNomor.Text;
   SERVER   := edServer.Text;
   LOCAL    := edLocal.Text;
   Close;
  end
 except
  on e: Exception do MessageDlg('Error: '+e.Message,mtError,[mbOK],0)
 end;
end;

procedure Tf_config.FormCreate(Sender: TObject);
begin
 Position := poDesktopCenter;
end;

end.
