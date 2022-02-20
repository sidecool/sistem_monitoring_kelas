unit u_client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, XPMan, ScktComp, ExtCtrls, WinProcs, IniFiles, Registry,
  jpeg;

type
  Tf_client = class(TForm)
    btnMasuk: TBitBtn;
    ClientSocket1: TClientSocket;
    XPManifest1: TXPManifest;
    edUser: TLabeledEdit;
    btnTutup: TBitBtn;
    GroupBox1: TGroupBox;
    TimerClient1: TTimer;
    LabelWaktu1: TLabel;
    lbTimerMulai: TLabel;
    LabelWaktu2: TLabel;
    lbTimerRun: TLabel;
    btnLogout: TBitBtn;
    btnShutdown: TBitBtn;
    btnRestart: TBitBtn;
    Image1: TImage;
    lbStatus: TLabel;
    LabelTitle3: TLabel;
    LabelNIS4: TLabel;
    LabelNama5: TLabel;
    lbNIS: TLabel;
    lbNama: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnMasukClick(Sender: TObject);
    procedure btnShutdownClick(Sender: TObject);
    procedure btnRestartClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnTutupClick(Sender: TObject);
    procedure ClientSocket1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure btnLogoutClick(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerClient1Timer(Sender: TObject);
    procedure edUserKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure defaultFormStyle;
    procedure loginFormStyle;

    procedure hideTaskbar;
    procedure showTaskbar;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  f_client: Tf_client;

  NoKomputer, UserLogin: String;
  TotalTimerClient: Integer;
  k_komputer,k_server,k_local: String;

  fs: TFormatSettings;

implementation

uses u_config;

{$R *.dfm}

procedure ganti_format;
begin
 fs.ThousandSeparator := '.';
 fs.DecimalSeparator  := ',';

 fs.DateSeparator   := '/';
 fs.TimeSeparator   := ':';
 fs.ShortDateFormat := 'd/M/yyyy';
 fs.LongDateFormat  := 'dd/MMMM/yyyy';
 fs.ShortTimeFormat := 'HH:mm';
 fs.LongTimeFormat  := 'HH:mm:ss';

 fs.ShortMonthNames[1]  := 'Jan';
 fs.ShortMonthNames[2]  := 'Feb';
 fs.ShortMonthNames[3]  := 'Mar';
 fs.ShortMonthNames[4]  := 'Apr';
 fs.ShortMonthNames[5]  := 'Mei';
 fs.ShortMonthNames[6]  := 'Jun';
 fs.ShortMonthNames[7]  := 'Jul';
 fs.ShortMonthNames[8]  := 'Ags';
 fs.ShortMonthNames[9]  := 'Sep';
 fs.ShortMonthNames[10] := 'Okt';
 fs.ShortMonthNames[11] := 'Nov';
 fs.ShortMonthNames[12] := 'Des';

 fs.LongMonthNames[1]  := 'Januari';
 fs.LongMonthNames[2]  := 'Februari';
 fs.LongMonthNames[3]  := 'Maret';
 fs.LongMonthNames[4]  := 'April';
 fs.LongMonthNames[5]  := 'Mei';
 fs.LongMonthNames[6]  := 'Juni';
 fs.LongMonthNames[7]  := 'Juli';
 fs.LongMonthNames[8]  := 'Agustus';
 fs.LongMonthNames[9]  := 'September';
 fs.LongMonthNames[10] := 'Oktober';
 fs.LongMonthNames[11] := 'November';
 fs.LongMonthNames[12] := 'Desember';

 fs.ShortDayNames[1] := 'Min';
 fs.ShortDayNames[2] := 'Sen';
 fs.ShortDayNames[3] := 'Sel';
 fs.ShortDayNames[4] := 'Rab';
 fs.ShortDayNames[5] := 'Kam';
 fs.ShortDayNames[6] := 'Jum';
 fs.ShortDayNames[7] := 'Sab';

 fs.LongDayNames[1] := 'Minggu';
 fs.LongDayNames[2] := 'Senin';
 fs.LongDayNames[3] := 'Selasa';
 fs.LongDayNames[4] := 'Rabu';
 fs.LongDayNames[5] := 'Kamis';
 fs.LongDayNames[6] := 'Jumat';
 fs.LongDayNames[7] := 'Sabtu';
end;

{ Tf_client }

function manipulasi_reg_windows(RootReg: Cardinal; PathReg, RegName: String; RegValue: Integer): String;
begin
 {
   Fungsi ini digunakan untuk memanipulasi registry windows
   misalkan untuk menutup Task Manager, Registry, menghapus Control Panel, dsb
 }
 if not(RegName = '') and not(RegValue = null) then
  begin
   with TRegistry.Create do
    begin
     try
      RootKey := RootReg;
      OpenKey(PathReg, True);
      WriteInteger(RegName, RegValue);
      Result := RegName;
     finally
      CloseKey;
      Free;
     end;
    end;
  end
 else
  begin
   ShowMessage('Error : System Registry Windows tidak dapat dijalankan ');
  end;
end;

function cek_reg_key(Filename: String): BOOL;
begin
 if not(Filename = '') then
  begin
   try
    begin
     with TRegistry.Create do
      try
       RootKey := HKEY_CURRENT_USER;
       OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run');
       if ValueExists(Filename) then
        begin
         Result := True;
        end
       else
        begin
         Result := False;
        end;
      finally
       CloseKey;
       Free;
      end;
    end;
   except
    Result := False;
   end;
  end
 else
  begin
   Result := False;
  end;
end;

procedure disable_reg_taskmgr_cpanel;
var
 Path: String;
begin
 Path := '\Software\Microsoft\Windows\CurrentVersion\Policies\System';
 // Disable Task Manager
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'DisableTaskMgr', 1); //1:Disable; 0:Enable
 // Disible Registry Edit
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'DisableRegistryTools', 1); //1:Disable; 0:Enable

 Path := '\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer';
 // Disable Control Panel Harus Restart
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'NoControlPanel', 1); //1:Disable; 0:Enable
 // Disable WinKeys Harus Restart
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'NoWinKeys', 1); //1:Disable; 0:Enable
end;

procedure enable_reg_taskmgr_cpanel;
var
 Path: String;
begin
 Path := '\Software\Microsoft\Windows\CurrentVersion\Policies\System';
 // Enable Task Manager
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'DisableTaskMgr', 0); //1:Disable; 0:Enable
 // Enable Registry Edit
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'DisableRegistryTools', 0); //1:Disable; 0:Enable

 Path := '\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer';
 // Enable Control Panel Harus Restart
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'NoControlPanel', 0); //1:Disable; 0:Enable
 // Enable WinKeys Harus Restart
 manipulasi_reg_windows(HKEY_CURRENT_USER, Path, 'NoWinKeys', 0); //1:Disable; 0:Enable
end;

function tambah_startup(Name, Filename: String): BOOL;
begin
 try
  begin
   if (FileExists(Filename)) and not(Name='') then
    begin
     Filename := StringReplace(Filename, '/', '\', [rfReplaceAll,rfIgnoreCase]);
     with TRegistry.Create do
      try
       RootKey := HKEY_CURRENT_USER;
       OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', True);
       WriteString(Name, '"'+Filename+'"');
      finally
       CloseKey;
       Free;
      end;
      Result := True;
    end
   else
    begin
     Result := False;
    end;
  end;
 except
  Result := False;
 end;
end;

procedure Tf_client.hideTaskbar;
begin
 ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_HIDE);
end;

procedure Tf_client.showTaskbar;
begin
 ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_SHOW);
end;

procedure Tf_client.defaultFormStyle;
begin
 FormStyle   := fsStayOnTop;
 BorderStyle := bsNone;
 Position    := poScreenCenter;
 WindowState := wsMaximized;
 //Pengaturan tombol
 edUser.Clear;
 LabelTitle3.Caption := 'LOGIN USER';
 edUser.Visible      := True;
 btnMasuk.Visible    := True;
 btnShutdown.Enabled := True;
 btnRestart.Enabled  := True;
 btnLogout.Visible   := False;
 btnShutdown.Top     := GetSystemMetrics(SM_CYSCREEN)-(btnShutdown.Height+10);
 btnRestart.Top      := GetSystemMetrics(SM_CYSCREEN)-(btnRestart.Height+10);

 lbNIS.Caption  := '-';
 lbNama.Caption := '-';

 lbNIS.Visible      := False;
 lbNama.Visible     := False;
 LabelNIS4.Visible  := False;
 LabelNama5.Visible := False;
end;

procedure Tf_client.loginFormStyle;
begin
 //ShowMessage('Resolusi : '+IntToStr(GetSystemMetrics(SM_CXSCREEN))+'x'+IntToStr(GetSystemMetrics(SM_CYSCREEN)));
 //Merubah Style Form
 WindowState := wsNormal;
 BorderStyle := bsSingle;
 BorderIcons := [biSystemMenu];

 //Merubah Ukuran Form
 Height      := 334;
 Width       := 305;

 //Meletakkan Form dipojok bawah
 Top         := GetSystemMetrics(SM_CYSCREEN)-Height;
 Left        := GetSystemMetrics(SM_CXSCREEN)-Width;

 //Pengaturan tombol
 LabelTitle3.Caption := 'Selamat datang';
 edUser.Visible      := False;
 btnMasuk.Visible    := False;
 btnShutdown.Enabled := False;
 btnRestart.Enabled  := False;
 btnLogout.Visible   := True;

 lbNIS.Visible      := True;
 lbNama.Visible     := True;
 LabelNIS4.Visible  := True;
 LabelNama5.Visible := True;
end;

procedure Tf_client.FormCreate(Sender: TObject);
var
 cari: String;
 Path, AppsPath: String;
 ClientIniFile: TIniFile;
begin
 ganti_format;
 KeyPreview := True; //Berhubungan dengan event OnKeyDown Form

 hideTaskbar;
 Application.ProcessMessages;
 defaultFormStyle;

 { ---------------- Membuat INI file untuk konfigurasi komputer ---------------- }
 Path := GetCurrentDir;

 cari := '';
 cari := FileSearch('SetClient.ini', GetCurrentDir);

 ClientIniFile := TIniFile.Create(Path+'\SetClient.ini');
 if cari='' then
  begin
   try
    f_config := Tf_config.Create(f_client);
    f_config.ShowModal;

    try
     ClientSocket1.Active  := False;

     NoKomputer    := 'Komputer-Lab-'+f_config.KOMPUTER;
     Caption       := NoKomputer;

     ClientSocket1.Host    := f_config.SERVER;
     ClientSocket1.Address := f_config.LOCAL;

     ClientSocket1.Active  := True;
    except
     on e: Exception do MessageDlg('Error: '+e.Message, mtError, [mbOK], 0);
    end;

   except
    f_config.Free;
   end;
  end
 else
  begin
   k_komputer := ClientIniFile.ReadString('Komputer','IDKomputer','');
   k_server   := ClientIniFile.ReadString('Komputer','ServerHost','');          //alamat servernya
   k_local    := ClientIniFile.ReadString('Komputer','LocalAddress','');        //alamat client

   try
    ClientSocket1.Active  := False;

    NoKomputer    := 'Komputer-Lab-'+k_komputer;
    Caption       := NoKomputer;

    ClientSocket1.Host    := k_server;
    ClientSocket1.Address := k_local;

    ClientSocket1.Active  := True;
   except
    on e: Exception do MessageDlg('Error: '+e.Message, mtError, [mbOK], 0);
   end;
  end;
 { ----------------------------------------------------------------------------- }

 { ------------------ Menambahkan Aplikasi ke Startup Program ------------------ }
 AppsPath := Path + '\Client.exe';
 if not(cek_reg_key('ClientApps')) then
  begin
   try
    //tambah_startup('ClientApps', AppsPath);
   except
    on e: Exception do MessageDlg('Error: '+e.Message, mtError, [mbOK], 0);
   end;
  end;
 { ----------------------------------------------------------------------------- }
 //disable_reg_taskmgr_cpanel;
end;

procedure Tf_client.btnMasukClick(Sender: TObject);
begin
 if edUser.Text = '' then
  begin
   MessageDlg('Peringatan: '+edUser.EditLabel.Caption+' tidak boleh kosong.', mtWarning, [mbOK], 0);
   edUser.SetFocus;
  end
 else
  begin
   UserLogin := edUser.Text;

   if ClientSocket1.Socket.Connected then
    begin
     try
      ClientSocket1.Socket.SendText(NoKomputer+'@c_login@'+UserLogin);          // Mengirim pesan ke Komputer Server
     except                                                                     // dengan format No. Komputer Client @ perintah @ NIS
      on e: Exception do MessageDlg('Error: '+e.Message,mtError,[mbOK],0)
     end;
    end
   else
    begin
     MessageDlg('Error: Koneksi ke Server terputus, Silahkan hubungi Admin Server.', mtError, [mbOK], 0);
    end;
  end;
end;

procedure Tf_client.btnShutdownClick(Sender: TObject);
begin
 WinExec('shutdown /s /t 0 /f', SW_NORMAL);
end;

procedure Tf_client.btnRestartClick(Sender: TObject);
begin
 WinExec('shutdown /r /t 0 /f', SW_NORMAL);
end;

procedure Tf_client.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose := False;
end;

procedure Tf_client.WMSysCommand(var Message: TWMSysCommand);
begin
 case (Message.CmdType and $FFF0) of
  SC_CLOSE   : begin
                Self.WindowState := wsMinimized;
                BorderIcons      := [biSystemMenu, biMinimize];
               end;
  SC_RESTORE : begin
                Self.WindowState := wsNormal;
                BorderIcons      := [biSystemMenu];
               end;
 end;
 inherited;
end;

procedure Tf_client.btnTutupClick(Sender: TObject);
begin
 //Hapus Kode Kalo sudah Fix
 ClientSocket1.Socket.SendText(NoKomputer+'@offline@'+ClientSocket1.Address);
 //enable_reg_taskmgr_cpanel;
 showTaskbar;
 Application.Terminate;
end;

procedure Tf_client.ClientSocket1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 lbStatus.Font.Color := clYellow;
 lbStatus.Font.Style := [];
 lbStatus.Caption    := 'Status : Sedang menghubungkan ke Server ...';
end;

procedure Tf_client.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Socket.SendText(NoKomputer+'@online@'+ClientSocket1.Address);
 lbStatus.Font.Color := clGreen;
 lbStatus.Caption    := 'Status : Terhubung dengan Server';
end;

procedure Tf_client.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Socket.SendText(NoKomputer+'@offline@'+ClientSocket1.Address);
 lbStatus.Font.Color := clRed;
 lbStatus.Font.Style := [fsBold];
 lbStatus.Caption    := 'Status : Tidak terhubung dengan Server';
 TimerClient1.Enabled   := False;

 btnLogout.Click;
 if f_client.Showing then
  begin
   ClientSocket1.Active := False;
   Sleep(1000);
   ClientSocket1.Active := True;
  end;
end;

procedure Tf_client.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
 ErrorCode := 0;
 lbStatus.Font.Color := clRed;
 lbStatus.Font.Style := [fsBold];
 lbStatus.Caption    := 'Status : Gagal menghubungkan ke Server ...';
 if f_client.Showing then
  begin
   ClientSocket1.Active   := False;
   Sleep(1000);
   ClientSocket1.Active   := True; //untuk merefresh connection
  end;
end;

procedure Tf_client.btnLogoutClick(Sender: TObject);
begin
 TimerClient1.Enabled := False;
 TotalTimerClient     := 0;
 ClientSocket1.Socket.SendText(NoKomputer+'@c_logout@'+UserLogin);
 defaultFormStyle;
end;

procedure Tf_client.ClientSocket1Read(Sender: TObject;                          // Membaca pesan dari Komputer Server
  Socket: TCustomWinSocket);
var
 StringList: TStringList;
begin
 StringList               := TStringList.Create;
 StringList.Delimiter     := '@';
 StringList.DelimitedText := Socket.ReceiveText;

 if StringList[0]=NoKomputer then
  begin
   if StringList[1]='s_notlogin' then
    begin
     MessageDlg('Peringatan: Admin server belum melakukan login, '+
                'harap siswa bersabar.', mtWarning, [mbOK], 0);
    end
   else if StringList[1]='s_mulai' then
    begin
     TotalTimerClient     := 0;
     lbTimerMulai.Caption := StringList[2];
     TimerClient1.Enabled := True;

     lbNIS.Caption  := StringList[4];
     lbNama.Caption := StringList[5];
     loginFormStyle;
     showTaskbar;
    end
   else if StringList[1]='s_notfound' then
    begin
     MessageDlg('Peringatan: Nomor Induk Siswa tidak terdaftar dikelas ini, '+
                'silahkan hubungi Admin Server.', mtWarning, [mbOK], 0);
    end
   else if StringList[1]='s_ulangi' then
    begin
     TotalTimerClient     := StrToInt(StringList[2]);
     lbTimerMulai.Caption := StringList[3];
     TimerClient1.Enabled := True;
    end
   else if StringList[1]='waktulogout' then
    begin

    end;
  end;

end;

procedure Tf_client.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 //Disable Alt+F4
 if ((ssAlt in Shift) and (Key = VK_F4)) then Key := 0;
end;

function Detik_ke_Waktu(const JmlDetik: Cardinal): Double;
var ms, ss, mm, hh: Cardinal;
begin
 hh := (JmlDetik mod 86400) div 3600;
 mm := ((JmlDetik mod 86400) mod 3600) div 60;
 ss := ((JmlDetik mod 86400) mod 3600) mod 60;
 ms := 0;

 Result :=EncodeTime(hh, mm, ss, ms);
end;

procedure Tf_client.TimerClient1Timer(Sender: TObject);
begin
 Inc(TotalTimerClient);
 lbTimerRun.Caption := TimeToStr(Detik_ke_Waktu(TotalTimerClient), fs);
end;

procedure Tf_client.edUserKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  btnMasuk.Click;
end;

end.
