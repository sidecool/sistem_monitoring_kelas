program Client;

uses
  Forms,
  u_client in '..\Source\u_client.pas' {f_client},
  u_config in '..\Source\u_config.pas' {f_config};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Client';
  Application.CreateForm(Tf_client, f_client);
  Application.Run;
end.
