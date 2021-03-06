unit u_server;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinSock, ScktComp, XPMan, Menus, ComCtrls, ExtCtrls, ImgList,
  StdCtrls, Buttons, ToolWin, INIFiles;

type
  Tf_server = class(TForm)
    XPManifest1: TXPManifest;
    ServerSocket1: TServerSocket;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    MasterData1: TMenuItem;
    Laporan1: TMenuItem;
    Pengaturan1: TMenuItem;
    N1: TMenuItem;
    Tutup1: TMenuItem;
    DataProfildanKlien1: TMenuItem;
    DataKelas1: TMenuItem;
    DataSiswa1: TMenuItem;
    Server1: TMenuItem;
    StatusBar1: TStatusBar;
    ListView1: TListView;
    ImageListView1: TImageList;
    ImageListButtonMenu1: TImageList;
    ToolBar1: TToolBar;
    btnViewReport: TToolButton;
    Separator1: TToolButton;
    Separator2: TToolButton;
    btnViewIcon: TToolButton;
    Separator3: TToolButton;
    Separator4: TToolButton;
    btnViewSimpan: TToolButton;
    PopupListViewMenu1: TPopupMenu;
    KontrolKomputerClient1: TMenuItem;
    LogoutKomputerClient1: TMenuItem;
    N2: TMenuItem;
    ShutdownKomputerClient1: TMenuItem;
    RestartKomputerClient1: TMenuItem;
    OnlineKomputerClientSementara1: TMenuItem;
    TimerServer1: TTimer;
    DataJurusan1: TMenuItem;
    N3: TMenuItem;
    DataGuru1: TMenuItem;
    DataLaboratorium1: TMenuItem;
    N4: TMenuItem;
    DataMataPelajaran1: TMenuItem;
    DataJadwalLaboratorium1: TMenuItem;
    N5: TMenuItem;
    DataUser1: TMenuItem;
    GantiPassword1: TMenuItem;
    Login1: TMenuItem;
    DataPengampuMataPelajaran1: TMenuItem;
    procedure Tutup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnViewReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure btnViewSimpanClick(Sender: TObject);
    procedure ListView1CustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LogoutKomputerClient1Click(Sender: TObject);
    procedure OnlineKomputerClientSementara1Click(Sender: TObject);
    procedure TimerServer1Timer(Sender: TObject);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    {-- Procedure Main Menu --}
    procedure Server1Click(Sender: TObject);
    procedure Pengaturan1Click(Sender: TObject);
    procedure DataProfildanKlien1Click(Sender: TObject);
    procedure Login1Click(Sender: TObject);
    procedure DataUser1Click(Sender: TObject);
    procedure GantiPassword1Click(Sender: TObject);
    procedure DataKelas1Click(Sender: TObject);
    procedure DataJurusan1Click(Sender: TObject);
    procedure DataLaboratorium1Click(Sender: TObject);
    procedure DataMataPelajaran1Click(Sender: TObject);
    procedure DataGuru1Click(Sender: TObject);
    procedure DataSiswa1Click(Sender: TObject);
    procedure DataPengampuMataPelajaran1Click(Sender: TObject);
    procedure DataJadwalLaboratorium1Click(Sender: TObject);
    procedure Laporan1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    StringList: TStringList;
    fs: TFormatSettings;

    procedure ganti_format;
  end;

var
  f_server: Tf_server;

  client_LocalAddress: String;
  p_nama,p_alamat,p_kota,p_provinsi,p_telepon,p_email,p_website: String;
  c_lab,c_nama_lab,c_jumlah: String;
  d_host,d_port,d_user,d_pass,d_base: String;



implementation

uses u_profil, u_kelas, u_siswa, u_pengaturan, u_dm, u_jurusan, u_lab,
  u_guru, u_mapel, u_jadwal_lab, u_laporan, u_user, u_ganti_paswd, u_login,
  u_mapel_ampu, DB, StrUtils, ZAbstractRODataset;

{$R *.dfm}

procedure Tf_server.ganti_format;
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

procedure Tf_server.Tutup1Click(Sender: TObject);
begin
 //Application.Terminate 
 CloseQuery;
end;

procedure default_menu;
begin
 with f_server do
  begin
   DataUser1.Visible      := False;
   GantiPassword1.Visible := False;
   MasterData1.Visible    := False;
   Laporan1.Visible       := False;

   btnViewReport.Enabled := False;
   btnViewIcon.Enabled   := False;
   btnViewSimpan.Enabled := False;
  end;
end;

procedure Tf_server.FormCreate(Sender: TObject);
var hMenuhandle:Integer;
begin
 ganti_format;
 KeyPreview := True;

 ServerSocket1.Active := True;                                                  //Mengaktifkan Server Socket
 Server1.Caption := 'Matikan Server';
 StatusBar1.Panels[0].Text := 'Server : Aktif';

 {- Kode untuk me-non-aktif-kan tombol title [X] (tombol Keluar/Tutup) -}

 hMenuhandle := GetSystemMenu(Handle, False);
 if (hMenuhandle <> 0) then DeleteMenu(hMenuhandle, SC_CLOSE,MF_BYCOMMAND);

 {----------------------------------------------------------------------}

 btnViewReport.ImageIndex := 2;
 btnViewIcon.ImageIndex   := 1;

 default_menu;
end;

procedure Tf_server.btnViewReportClick(Sender: TObject);
begin
 if Sender = btnViewReport then
  begin
   ListView1.ViewStyle      := vsReport;
   btnViewReport.ImageIndex := 2;
   btnViewIcon.ImageIndex   := 1;
  end
 else if Sender = btnViewIcon then
  begin
   ListView1.ViewStyle      := vsIcon;
   btnViewReport.ImageIndex := 0;
   btnViewIcon.ImageIndex   := 3;
  end;
end;

procedure tampil_komputer_client(JmlClient: Integer);
var
 i: Integer;
 barisLV: TListItem;
begin
 with f_server do
  begin
   ListView1.Clear;
   for i:=1 to JmlClient do
    begin
     barisLV := ListView1.Items.Add;

     barisLV.Caption := 'Komputer-Lab-'+IntToStr(i);
     barisLV.SubItems.Add('');                                                  //Kolom NIS Default Kosong
     barisLV.SubItems.Add('');                                                  //Kolom Nama Pengguna Default Kosong
     barisLV.SubItems.Add('00:00:00');
     barisLV.SubItems.Add('00:00:00');
     barisLV.SubItems.Add('00:00:00');
     barisLV.SubItems.Add('Offline');                                           //Offline : Komputer tidak aktif / Client error
                                                                                //Online  : Komputer aktif
                                                                                //Login   : Komputer sedang digunakan
                                                                                //Logout  : Komputer telah digunakan

     barisLV.SubItems.Add('');                                                  //Kolom IP Address Default Kosong
     barisLV.ImageIndex := 0;
    end;
  end;
end;

procedure buat_system_ini;
var
 cari: String;
 FileINI: TIniFile;
begin
with f_server do
 begin
  c_jumlah := '0';
  cari     := '';
  cari := FileSearch('system.ini', GetCurrentDir);                              //Mencari file system.ini pada direktori aplikasi

  FileINI := TIniFile.Create(GetCurrentDir+'\system.ini');                      //Membuat file system.ini pada direktori aplikasi
  if cari='' then
   begin
    try
     f_profil := Tf_profil.Create(f_server);
     f_profil.Position := poDesktopCenter;
     f_profil.ShowModal;
     DMServer.ID_LAB := FileINI.ReadString('CLIENT','id_lab','');
     DMServer.LAB    := FileINI.ReadString('CLIENT','nm_lab','');
     c_jumlah        := FileINI.ReadString('CLIENT','jumlah','');
     tampil_komputer_client(StrToInt(c_jumlah));
    except
     f_profil.Free;
    end;
   end
  else
   begin
    p_nama     := FileINI.ReadString('PROFIL','nama','');                       //Membaca nilai dari file system.ini
    p_alamat   := FileINI.ReadString('PROFIL','alamat','');
    p_kota     := FileINI.ReadString('PROFIL','kota','');
    p_provinsi := FileINI.ReadString('PROFIL','provinsi','');
    p_telepon  := FileINI.ReadString('PROFIL','telepon','');
    p_email    := FileINI.ReadString('PROFIL','email','');
    p_website  := FileINI.ReadString('PROFIL','website','');

    c_lab      := FileINI.ReadString('CLIENT','id_lab','');
    c_nama_lab := FileINI.ReadString('CLIENT','nm_lab','');
    c_jumlah   := FileINI.ReadString('CLIENT','jumlah','');

    try
     DMServer.ID_LAB := c_lab;
     DMServer.LAB    := c_nama_lab;
     tampil_komputer_client(StrToInt(c_jumlah));
    except
     on e: Exception do
      begin
       MessageDlg('Error: '+e.Message,mtError,[mbOK],0);
       try
        f_profil := Tf_profil.Create(f_server);
        f_profil.Position := poDesktopCenter;
        f_profil.ShowModal;
        DMServer.ID_LAB := FileINI.ReadString('CLIENT','id_lab','');
        DMServer.LAB    := FileINI.ReadString('CLIENT','nm_lab','');
        tampil_komputer_client(StrToInt(c_jumlah));
       except
        f_profil.Free;
       end;
      end;
    end;
   end;
  FileINI.Free;
 end;
end;

procedure buat_config_ini;
var
 cari: String;
 FileINI: TIniFile;
begin
 cari := '';
 cari := FileSearch('config.ini', GetCurrentDir);                               //Mencari file config.ini pada direktori aplikasi

 FileINI := TIniFile.Create(GetCurrentDir+'\config.ini');                       //Membuat file config.ini pada direktori aplikasi
 if cari='' then
  begin
   try
    f_pengaturan := Tf_pengaturan.Create(f_server);
    f_pengaturan.ShowModal;
   except
    f_pengaturan.Free;
   end;
  end
 else
  begin
   d_host := FileINI.ReadString('DATABASE','host','');                          //Membaca nilai dari file config.ini
   d_port := FileINI.ReadString('DATABASE','port','');
   d_user := FileINI.ReadString('DATABASE','user','');
   d_pass := FileINI.ReadString('DATABASE','password','');
   d_base := FileINI.ReadString('DATABASE','database','');

   with DMServer.ZConnection1 do
    begin
     try
      Connected := False;

      Database := d_base;
      HostName := d_host;
      Port     := StrToInt(d_port);
      User     := d_user;
      Password := d_pass;

      Connected := True;
     except
      on e: Exception do
       begin
        MessageDlg('Error: '+e.Message,mtError,[mbOK],0);
        try
         f_pengaturan := Tf_pengaturan.Create(f_server);
         f_pengaturan.ShowModal;
        except
         f_pengaturan.Free;
         Connected := False;
         Connected := True;
        end;
       end;
     end;
    end;
  end;
 FileINI.Free;
end;

procedure Tf_server.FormShow(Sender: TObject);
begin
 buat_config_ini;
 if DMServer.ZConnection1.Connected=False then
  f_server.StatusBar1.Panels[1].Text := 'Database : Gagal Terhubung'
 else if DMServer.ZConnection1.Connected=True then
  f_server.StatusBar1.Panels[1].Text := 'Database : Terhubung';
  
 buat_system_ini;
 tampil_komputer_client(StrToInt(c_jumlah));                                    //Memanggil procedure untuk menampilkan jumlah komputer client
 StatusBar1.Panels[5].Text := 'Lab : '+DMServer.LAB;
end;

function WaktuToDetik(Waktu: TTime): Double;
var
 Jam, Menit, Detik, MDetik: Word;
 NDetik: Double;
begin
 DecodeTime(Waktu,Jam,Menit,Detik,MDetik);
 NDetik := (Jam*3600)+(Menit*60)+(Detik);
 Result := NDetik;
end;

function CariCaption(ListView: TListView; const Str: String; Col: Integer): Integer;
var
 Index, i: Integer;
 ListViewItem: TListItem;
 Cari: Boolean;
begin
 Index := -1;
 Assert(Assigned(ListView));
 Assert((ListView.ViewStyle = vsReport) or (Col = 0));
 Assert(Str <> '');

 for i:=0 to ListView.Items.Count-1 do
  begin
   ListViewItem := ListView.Items[i];

   if Col = 0 then
    Cari := AnsiCompareText(ListViewItem.Caption, Str) = 0
   else if Col > 0 then
    begin
     if ListViewItem.SubItems.Count >= Col then
      Cari := AnsiCompareText(ListViewItem.SubItems[Col-1], Str) = 0
     else
      Cari := False;
    end
   else
    Cari := False;

   if Cari then
    begin
     ListView.Selected := ListViewItem;
     Index             := ListView.Selected.Index;
    end;
  end;
  Result := Index;
end;

procedure Tf_server.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
 Waktu, UserOnline, tempWaktuSelesai: String;
 IdxCari, i: Integer;
 DetikLama: Double;
begin
 try
  StringList               := TStringList.Create;                               // Mengenalkan sebuah Class TStringList
  StringList.Delimiter     := '@';                                              // Mengenalkan Delimeter/Pembatas pada sebuah StringList
  StringList.DelimitedText := Socket.ReceiveText;                               // Mengisi StringList berdasarkan Teks yang diterima Socket yang berasal dari Client

  case AnsiIndexStr(StringList[1],['online','offline','c_login','c_logout']) of
   0: // Client Online
      begin
       IdxCari := CariCaption(ListView1, StringList[0], 0);                     // Mencari client yang online berdasarkan StringList[0] (NoKomputer)

       ListView1.Items[IdxCari].SubItems.Strings[5] := 'Online';                // Merubah kolom Status menjadi Online
       ListView1.Items[IdxCari].SubItems.Strings[6] := StringList[2];           // Mengisi kolom yang tersembunyi dengan StringList[2] (ClientSocket1.Address)
      end;
   1: // Client Offline
      begin
       client_LocalAddress := StringList[2];                                    // Mengisi variabel lokal dengan StringList[2] (ClientSocket1.Address)
      end;
   2: // Client Login
      begin
       if (DMServer.ID_KELAS <> '-') and (DMServer.ID_JURUSAN <> '-') then
        begin
         with DMServer.ZQEksekusi2 do                                           // Cek Siswa Login adalah Kelas dan Jurusan ini
          begin                                                                 //
           Close;
           SQL.Clear;
           SQL.Text := 'SELECT NO_INDUK_SISWA, NM_SISWA FROM T_SISWA '+
                       'WHERE ID_KELAS='+#39+DMServer.ID_KELAS+#39+' AND '+
                       'ID_JURUSAN='+#39+DMServer.ID_JURUSAN+#39+' AND '+
                       'NO_INDUK_SISWA='+#39+StringList[2]+#39;
           Open;

           if FieldByName('NO_INDUK_SISWA').AsString <> '' then
            begin
             Waktu := TimeToStr(Now);                                           // Mengisi variable lokal dengan Waktu Sekarang

             IdxCari := CariCaption(ListView1, StringList[0], 0);               // -
             if ListView1.Items[IdxCari].SubItems.Strings[5]='Online' then      // jika Status client = Online
              begin
               ListView1.Items[IdxCari].SubItems.Strings[2] := Waktu;           // Mengisi kolom Waktu Login dengan nilai variabel lokal
               Socket.SendText(StringList[0]+'@s_mulai@'+Waktu+'@'+             // Mengirim perintah start ke Client
                               IntToStr(ListView1.Items.Count)+'@'+
                               FieldByName('NO_INDUK_SISWA').AsString+'@'+
                               FieldByName('NM_SISWA').AsString);
              end
             else
              begin
               DetikLama := WaktuToDetik(StrToTime(                             // -
                            ListView1.Items[IdxCari].SubItems.Strings[4]));
               Socket.SendText(StringList[0]+'@s_ulangi@'+                      // -
                               FloatToStr(DetikLama)+'@'+
                               ListView1.Items[IdxCari].SubItems.Strings[2]+'@'+
                               IntToStr(ListView1.Items.Count));
              end;

             {for i:=2 to StringList.Count-1 do
              begin
               UserOnline := UserOnline+' '+StringList[i];
              end;}
             ListView1.Items[IdxCari].SubItems.Strings[0] := StringList[2]; //UserOnline;        // Menuliskan nama user yang login
             ListView1.Items[IdxCari].SubItems.Strings[1] := FieldByName('NM_SISWA').AsString;
             ListView1.Items[IdxCari].SubItems.Strings[5] := 'Login';           // Mengubah status menjadi login
             ListView1.Items[IdxCari].ImageIndex          := 1;                 // Mengubah Icon Client menjadi aktif
            end
           else
            begin
             Socket.SendText(StringList[0]+'@s_notfound');                      // Pesan dikirim ke Client NIS tidak ditemukan
            end;
          end;
        end
       else
        begin
         Socket.SendText(StringList[0]+'@s_notlogin');                          // Pesan dikirim ke Client error Server belum login
        end;
      end;
   3: // Client Logout
      begin
       Waktu := TimeToStr(Now);

       IdxCari := CariCaption(ListView1, StringList[0], 0);
       ListView1.Items[IdxCari].SubItems.Strings[5] := 'Logout';

       tempWaktuSelesai := TimeToStr(Now);
       ListView1.Items[IdxCari].SubItems.Strings[3] := tempWaktuSelesai;

       {for i:=0 to ServerSocket1.Socket.ActiveConnections-1 do
        begin
         ServerSocket1.Socket.Connections[i].SendText(StringList[0]+'@waktulogout@'+
                                                      tempWaktuSelesai);
        end;}

       ListView1.Items[IdxCari].ImageIndex := 0;
      end;

  end;
 except
  on e: Exception do MessageDlg('Error: '+e.Message,mtError,[mbOK],0)
 end;
end;

procedure Tf_server.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 //Menyimpan daftar client aktif
end;

procedure Tf_server.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
 IdxCari: Integer;
begin
 //Mencari daftar client tidak aktif
 try
  IdxCari := CariCaption(ListView1, client_LocalAddress, 7);
  if ListView1.Items[IdxCari].SubItems.Strings[6]=client_LocalAddress then
   begin
    ListView1.Items[IdxCari].SubItems.Strings[5] := 'Offline';
    ListView1.Items[IdxCari].SubItems.Strings[6] := '';
   end;
 except
  on e: Exception do MessageDlg('Error: '+e.Message,mtError,[mbOK],0)
 end;
end;

procedure Tf_server.btnViewSimpanClick(Sender: TObject);
var
 n: Integer;
 h_kode,h_user,h_jadwal,h_login,h_logout: String;
 kondisi: String;
begin
 try
  for n:=0 to StrToInt(c_jumlah)-1 do
   begin
    if ListView1.Items[n].SubItems.Strings[0] <> '' then                        // NIS tidak kosong
     begin
      h_user   := ListView1.Items[n].SubItems.Strings[0];
      h_jadwal := DMServer.ID_JADWAL;
      h_login  := FormatDateTime('yyyy-mm-dd', Now)+' '+
                  ListView1.Items[n].SubItems.Strings[2];
      h_logout := FormatDateTime('yyyy-mm-dd', Now)+' '+
                  ListView1.Items[n].SubItems.Strings[3];

      h_kode   := FormatDateTime('yyyymmdd', Now)+
                  LeftStr(ListView1.Items[n].SubItems.Strings[2],2)+'-'+h_user;
      with DMServer.ZQEksekusi2 do
       begin
        kondisi := 'Gagal';

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO T_HISTORI_PEMAKAIAN VALUES ('+#39+h_kode+#39+','+
                                                               #39+h_user+#39+','+
                                                               #39+h_jadwal+#39+','+
                                                               #39+h_login+#39+','+
                                                               #39+h_logout+#39+')';
        ExecSQL;

        kondisi := 'Berhasil';
       end;
     end;
   end;
  tampil_komputer_client(StrToInt(c_jumlah));                                   //Update Jumlah Client
 except
  on e: Exception do
   begin
    MessageDlg('Error: '+e.Message,mtError,[mbOK],0);
    kondisi := 'Gagal';
   end;
 end;
 if kondisi = 'Berhasil' then
  ShowMessage('Data berhasil disimpan ke tabel riwayat penggunaan.')
 else
  ShowMessage('Terjadi kesalahan, tidak dapat menyimpan riwayat penggunaan.')
end;

procedure Tf_server.ListView1CustomDrawItem(Sender: TCustomListView;            // Untuk merubah warna baris pada ListItem sesuai Status
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
 if Item.SubItems.Strings[5]='Offline' then
  begin
   ListView1.Canvas.Font.Color  := clYellow;
   ListView1.Canvas.Brush.Color := clGray;
  end;

 if Item.SubItems.Strings[5]='Login' then
  begin
   ListView1.Canvas.Font.Color  := clBlue;
   ListView1.Canvas.Brush.Color := clLime;
  end;

 if Item.SubItems.Strings[5]='Logout' then
  begin
   ListView1.Canvas.Font.Color  := clYellow;
   ListView1.Canvas.Brush.Color := clRed;
  end;
end;

procedure Tf_server.LogoutKomputerClient1Click(Sender: TObject);
begin

 ListView1.Selected.SubItems.Strings[5] := 'Logout';
 ListView1.Selected.ImageIndex := 0;
end;

procedure Tf_server.OnlineKomputerClientSementara1Click(Sender: TObject);
begin
 // Kode Sementara saja, nanti dihapus...dipindahkan ke Client
 ListView1.Selected.SubItems.Strings[5] := 'Login';
 ListView1.Selected.ImageIndex := 1;
end;

procedure Tf_server.TimerServer1Timer(Sender: TObject);
var i: Integer;
    Waktu: TDateTime;
begin
 try
  for i:=0 to ListView1.Items.Count-1 do
   begin
    if ListView1.Items[i].SubItems.Strings[5]='Login' then
     begin
      Waktu := StrToTime(ListView1.Items[i].SubItems.Strings[2])-Now;
      ListView1.Items[i].SubItems.Strings[4] := TimeToStr(Waktu, fs);
     end;
   end;
 except
 end;
end;

procedure Tf_server.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 with CreateMessageDialog('Apakah Anda yakin akan menutup Program ini?', mtConfirmation, [mbYes, mbNo]) do
  begin
   Caption   := 'Konfirmasi';
   Font.Name := 'Tahoma';
   Font.Size := 8;
   TButton(FindComponent('Yes')).Caption := 'Ya';
   TButton(FindComponent('No')).Caption  := 'Tidak';

   case ShowModal of
    mrYes : //if DMServer.MyInputBox('Autentikasi Administrator','Password','') = 'dilarangmasukkecualiadmin' then
             begin
              Application.Terminate;
             end;
            //else
            // begin
            //  CanClose := False;
            // end;
    mrNo  : CanClose := False;
   end;
  end;
end;

{-- Procedure Main Menu --}

procedure Tf_server.Server1Click(Sender: TObject);
begin
 if ServerSocket1.Active = True then
  begin
   ServerSocket1.Active := False;
   Server1.Caption := 'Hidupkan Server';
   StatusBar1.Panels[0].Text := 'Server : Tidak Aktif';
  end
 else if ServerSocket1.Active = False then
  begin
   ServerSocket1.Active := True;
   Server1.Caption := 'Matikan Server';
   StatusBar1.Panels[0].Text := 'Server : Aktif';
  end;
end;

procedure Tf_server.Pengaturan1Click(Sender: TObject);
begin
 try
  f_pengaturan := Tf_pengaturan.Create(Self);
  if DMServer.USERNAME='MYADMIN' then
   f_pengaturan.ShowModal
  else if DMServer.MyInputBox('Autentikasi Administrator','Password','') = 'dilarangmasukkecualiadmin' then
   f_pengaturan.ShowModal;
 except
  f_pengaturan.Free;
 end;
end;

procedure Tf_server.DataProfildanKlien1Click(Sender: TObject);
begin
 try
  f_profil := Tf_profil.Create(Self);
  if DMServer.USERNAME='MYADMIN' then
   f_profil.ShowModal
  else if DMServer.MyInputBox('Autentikasi Administrator','Password','') = 'dilarangmasukkecualiadmin' then
   f_profil.ShowModal;
  tampil_komputer_client(StrToInt(f_profil.edKomputer.Text));                   //Update Jumlah Client
 except
  f_profil.Free;
 end;
end;

procedure Tf_server.Login1Click(Sender: TObject);
begin
 if Login1.Caption = '&Login' then
  begin
   try
    f_login := Tf_login.Create(Self);
    f_login.ShowModal;
   except
    f_login.Free;
   end;
  end
 else if Login1.Caption = '&Logout' then
  begin
   default_menu;
   Login1.Caption := '&Login';
  end;

 StatusBar1.Panels[2].Text := 'Pengajar : '+DMServer.USERNAME;
 StatusBar1.Panels[3].Text := 'Kelas : '+DMServer.KELAS+' ('+DMServer.ID_JURUSAN+')';
 StatusBar1.Panels[4].Text := 'Mapel : '+DMServer.MAPEL;
end;

procedure Tf_server.DataUser1Click(Sender: TObject);
begin
 try
  f_user := Tf_user.Create(Self);
  f_user.ShowModal;
 except
  f_user.Free;
 end;
end;

procedure Tf_server.GantiPassword1Click(Sender: TObject);
begin
 try
  f_ganti_paswd := Tf_ganti_paswd.Create(Self);
  f_ganti_paswd.ShowModal;
 except
  f_ganti_paswd.Free;
 end;
end;

procedure Tf_server.DataKelas1Click(Sender: TObject);
begin
 try
  f_kelas := Tf_kelas.Create(Self);
  f_kelas.ShowModal;
 except
  f_kelas.Free;
 end;
end;

procedure Tf_server.DataJurusan1Click(Sender: TObject);
begin
 try
  f_jurusan := Tf_jurusan.Create(Self);
  f_jurusan.ShowModal;
 except
  f_jurusan.Free;
 end;
end;

procedure Tf_server.DataLaboratorium1Click(Sender: TObject);
begin
 try
  f_lab := Tf_lab.Create(Self);
  f_lab.ShowModal;
 except
  f_lab.Free;
 end;
end;

procedure Tf_server.DataMataPelajaran1Click(Sender: TObject);
begin
 try
  f_mapel := Tf_mapel.Create(Self);
  f_mapel.ShowModal;
 except
  f_mapel.Free;
 end;
end;

procedure Tf_server.DataGuru1Click(Sender: TObject);
begin
 try
  f_guru := Tf_guru.Create(Self);
  f_guru.ShowModal;
 except
  f_guru.Free;
 end;
end;

procedure Tf_server.DataSiswa1Click(Sender: TObject);
begin
 try
  f_siswa := Tf_siswa.Create(Self);
  f_siswa.ShowModal;
 except
  f_siswa.Free;
 end;
end;

procedure Tf_server.DataPengampuMataPelajaran1Click(Sender: TObject);
begin
 try
  f_mapel_ampu := Tf_mapel_ampu.Create(Self);
  f_mapel_ampu.ShowModal;
 except
  f_mapel_ampu.Free;
 end;
end;

procedure Tf_server.DataJadwalLaboratorium1Click(Sender: TObject);
begin
 try
  f_jadwal_lab := Tf_jadwal_lab.Create(Self);
  f_jadwal_lab.ShowModal;
 except
  f_jadwal_lab.Free;
 end;
end;

procedure Tf_server.Laporan1Click(Sender: TObject);
begin
 try
  f_laporan := Tf_laporan.Create(Self);
  f_laporan.NAMA   := p_nama;
  f_laporan.ALAMAT := p_alamat;
  f_laporan.KOTA   := p_kota;
  f_laporan.PROV   := p_provinsi;
  f_laporan.TELP   := p_telepon;
  f_laporan.EMAIL  := p_email;
  f_laporan.WWW    := p_website;
  f_laporan.ShowModal;
 except
  f_laporan.Free;
 end;
end;

procedure Tf_server.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 //Disable Alt+F4
 if ((ssAlt in Shift) and (Key = VK_F4)) then Key := 0;
end;

end.
