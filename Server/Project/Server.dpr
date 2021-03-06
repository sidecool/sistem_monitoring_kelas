program Server;

uses
  Forms,
  u_server in '..\Source\u_server.pas' {f_server},
  u_dm in '..\Source\u_dm.pas' {DMServer: TDataModule},
  u_profil in '..\Source\u_profil.pas' {f_profil},
  u_jadwal_lab in '..\Source\u_jadwal_lab.pas' {f_jadwal_lab},
  u_lab in '..\Source\u_lab.pas' {f_lab},
  u_pengaturan in '..\Source\u_pengaturan.pas' {f_pengaturan},
  u_mapel in '..\Source\u_mapel.pas' {f_mapel},
  u_kelas in '..\Source\u_kelas.pas' {f_kelas},
  u_user in '..\Source\u_user.pas' {f_user},
  u_mapel_ampu in '..\Source\u_mapel_ampu.pas' {f_mapel_ampu},
  u_siswa in '..\Source\u_siswa.pas' {f_siswa},
  u_laporan in '..\Source\u_laporan.pas' {f_laporan},
  u_guru in '..\Source\u_guru.pas' {f_guru},
  u_ganti_paswd in '..\Source\u_ganti_paswd.pas' {f_ganti_paswd},
  u_login in '..\Source\u_login.pas' {f_login},
  u_jurusan in '..\Source\u_jurusan.pas' {f_jurusan},
  u_kelas_lab in '..\Source\u_kelas_lab.pas' {f_kelas_lab};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Server';
  Application.CreateForm(TDMServer, DMServer);
  Application.CreateForm(Tf_server, f_server);
  Application.Run;
end.
