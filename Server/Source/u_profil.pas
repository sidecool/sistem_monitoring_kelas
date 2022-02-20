unit u_profil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, INIFiles;

type
  Tf_profil = class(TForm)
    GroupBoxProfil1: TGroupBox;
    edNama: TLabeledEdit;
    edAlamat: TLabeledEdit;
    edKota: TLabeledEdit;
    edProvinsi: TLabeledEdit;
    edTelepon: TLabeledEdit;
    edEmail: TLabeledEdit;
    edWebsite: TLabeledEdit;
    edKomputer: TLabeledEdit;
    btnSimpan: TBitBtn;
    StaticText1: TStaticText;
    cbLab: TComboBox;
    lbLab: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edNamaKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimpanClick(Sender: TObject);
  private
    { Private declarations }
    cari: String;
    FileINI: TIniFile;
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
  f_profil: Tf_profil;

implementation

uses u_dm;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_profil.Perform(WM_NEXTDLGCTL,0,0);
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

constructor TString_.Create(const AStr: String);
begin
 inherited Create;
 FStr := AStr;
end;

function ComboIndex(Combo: TCustomComboBox; Kode: String): Integer;
var
 i: Integer;
begin
 i := 0;
 while i < Combo.Items.Count do
  begin
   if TString_(Combo.Items.Objects[i]).Str = Kode then
    begin
     ComboIndex := i;
    end;
   i := i+1;
  end;
end;

procedure tampil_lab;
begin
 with f_profil do
  begin
   try
    cbLab.Clear;
    cbLab.Items.AddObject('- Pilih Laboratorium', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT ID_LAB AS KODE, NM_LAB AS NAMA FROM T_LAB ORDER BY NM_LAB';
      Open;

      while not DMServer.ZQEksekusi2.Eof do
       begin
        cbLab.Items.AddObject(FieldByName('NAMA').AsString, TString_.Create(FieldByName('KODE').AsString));
        Next;
       end;
     end;
    cbLab.ItemIndex := 0;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_profil.FormShow(Sender: TObject);
begin
 tampil_lab;
 cari := '';
 cari := FileSearch('system.ini', GetCurrentDir);

 FileINI := TIniFile.Create(GetCurrentDir+'\system.ini');
 if cari='' then
  begin
   MessageDlg('Error: file system.ini tidak ditemukan', mtError, [mbOK], 0);
  end
 else
  begin
   edNama.Text     := FileINI.ReadString('PROFIL','nama','');
   edAlamat.Text   := FileINI.ReadString('PROFIL','alamat','');
   edKota.Text     := FileINI.ReadString('PROFIL','kota','');
   edProvinsi.Text := FileINI.ReadString('PROFIL','provinsi','');
   edTelepon.Text  := FileINI.ReadString('PROFIL','telepon','');
   edEmail.Text    := FileINI.ReadString('PROFIL','email','');
   edWebsite.Text  := FileINI.ReadString('PROFIL','website','');

   cbLab.ItemIndex := ComboIndex(cbLab, FileINI.ReadString('CLIENT','id_lab',''));
   edKomputer.Text := FileINI.ReadString('CLIENT','jumlah','');
  end;
 FileINI.Free;

 edNama.SetFocus;
end;

procedure Tf_profil.edNamaKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
 else if ((Sender = edKomputer) or (Sender = edTelepon)) and (not(keyangka(Key))) then Abort
end;

procedure Tf_profil.btnSimpanClick(Sender: TObject);
begin
 if edNama.Text='' then
  begin
   MessageDlg(edNama.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edNama.SetFocus;
  end
 else if edAlamat.Text='' then
  begin
   MessageDlg(edAlamat.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edAlamat.SetFocus;
  end
 else if edKota.Text='' then
  begin
   MessageDlg(edKota.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKota.SetFocus;
  end
 else if edProvinsi.Text='' then
  begin
   MessageDlg(edProvinsi.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edProvinsi.SetFocus;
  end
 else if edTelepon.Text='' then
  begin
   MessageDlg(edTelepon.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edTelepon.SetFocus;
  end
 else if edEmail.Text='' then
  begin
   MessageDlg(edEmail.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edEmail.SetFocus;
  end
 else if edWebsite.Text='' then
  begin
   MessageDlg(edWebsite.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edWebsite.SetFocus;
  end
 else if edKomputer.Text='' then
  begin
   MessageDlg(edKomputer.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKomputer.SetFocus;
  end
 else if cbLab.ItemIndex<1 then
  begin
   MessageDlg(lbLab.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   cbLab.SetFocus;
  end
 else
  begin
   try
    begin
     DMServer.ID_LAB := '-';
     DMServer.LAB    := '-';

     FileINI := TIniFile.Create(GetCurrentDir+'\system.ini');
     FileINI.WriteString('PROFIL','nama',edNama.Text);
     FileINI.WriteString('PROFIL','alamat',edAlamat.Text);
     FileINI.WriteString('PROFIL','kota',edKota.Text);
     FileINI.WriteString('PROFIL','provinsi',edProvinsi.Text);
     FileINI.WriteString('PROFIL','telepon',edTelepon.Text);
     FileINI.WriteString('PROFIL','email',edEmail.Text);
     FileINI.WriteString('PROFIL','website',edWebsite.Text);

     FileINI.WriteString('CLIENT','id_lab',TString_(cbLab.Items.Objects[cbLab.ItemIndex]).Str);
     FileINI.WriteString('CLIENT','nm_lab',cbLab.Text);
     FileINI.WriteString('CLIENT','jumlah',edKomputer.Text);
     FileINI.Free;

     ShowMessage('Berhasil menyimpan system.ini');
     Close;
    end
   except
    on e: Exception do MessageDlg('Error: '+e.Message,mtError,[mbOK],0)
   end;
  end;
end;

end.
