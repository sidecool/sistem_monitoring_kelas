unit u_dm;

interface

uses
  Forms, StdCtrls, Windows, Graphics, Consts, Controls, Dialogs,
  SysUtils, Classes, ZDataset, ZConnection, DB, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractConnection;

type
  TDMServer = class(TDataModule)
    ZConnection1: TZConnection;
    ZQEksekusi1: TZQuery;
    ZQEksekusi2: TZQuery;
    ZQTampil1: TZQuery;
    ZQTampil2: TZQuery;
    DataSource1: TDataSource;
    ZQLaporan1: TZQuery;
    ZQLaporan2: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    USERNAME, NIP, NAMA: String;
    ID_KELAS, ID_JURUSAN, ID_MAPEL, ID_LAB, ID_JADWAL: String;
    KELAS, JURUSAN, MAPEL, LAB: String;

    function MyInputQuery(const ACaption, APrompt: string;
      var Value: string): Boolean;
    function MyInputBox(const ACaption, APrompt, ADefault: string): string;
    function GetAveCharSize(Canvas: TCanvas): TPoint;
  end;

var
  DMServer: TDMServer;

implementation

{$R *.dfm}

{ TDMServer }

function TDMServer.MyInputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Font.Name := 'Webdings';
        PasswordChar := 'd';
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;          
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end
    finally
      Form.Free;
    end;
end;

function TDMServer.MyInputBox(const ACaption, APrompt,
  ADefault: string): string;
begin
  Result := ADefault;
  MyInputQuery(ACaption, APrompt, Result);
end;

function TDMServer.GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

procedure TDMServer.DataModuleCreate(Sender: TObject);
begin
 USERNAME    := '-';
 NIP         := '-';
 NAMA        := '-';
 ID_KELAS    := '-';
 ID_JURUSAN  := '-';
 ID_MAPEL    := '-';
 ID_LAB      := '-';
 KELAS       := '-';
 JURUSAN     := '-';
 MAPEL       := '-';
 LAB         := '-';
end;

end.
