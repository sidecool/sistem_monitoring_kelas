unit u_jadwal_lab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask;

type
  Tf_jadwal_lab = class(TForm)
    GroupBox1: TGroupBox;
    lbTA: TLabel;
    Panel1: TPanel;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnTutup: TBitBtn;
    DTPTahun: TDateTimePicker;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    lbLab: TLabel;
    cbLab: TComboBox;
    cbMapel: TComboBox;
    lbMapel: TLabel;
    lbHari: TLabel;
    lbMulai: TLabel;
    edKode: TLabeledEdit;
    lbSelesai: TLabel;
    cbHari: TComboBox;
    DTPMulai: TDateTimePicker;
    DTPSelesai: TDateTimePicker;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edKodeKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimpanClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure edKodeExit(Sender: TObject);
    procedure DTPTahunChange(Sender: TObject);
    procedure cbHariChange(Sender: TObject);
  private
    { Private declarations }
    ID_JADWAL_LAMA: String;
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
  f_jadwal_lab: Tf_jadwal_lab;

implementation

uses u_dm, DateUtils, DB;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_jadwal_lab.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_jadwal_lab.btnTutupClick(Sender: TObject);
begin
 Close;
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

procedure form_default;
begin
 with f_jadwal_lab do
  begin
   edKode.Clear;
   ID_JADWAL_LAMA    := '';
   cbLab.ItemIndex   := 0;
   cbMapel.ItemIndex := 0;
   DTPTahun.Date     := Now;
   cbHari.ItemIndex  := 0;
   DTPMulai.Time     := StrToTime('0:00:00');
   DTPSelesai.Time   := StrToTime('0:00:00');
  end;
end;

procedure form_isi;
begin
 with f_jadwal_lab do
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM T_JADWAL_LAB WHERE ID_JADWAL='+#39+edKode.Text+#39;
      Open;

      ID_JADWAL_LAMA := '';
      if FieldByName('ID_JADWAL').AsString <> '' then
       begin
        ID_JADWAL_LAMA    := FieldByName('ID_JADWAL').AsString;
        edKode.Text       := FieldByName('ID_JADWAL').AsString;
        cbLab.ItemIndex   := ComboIndex(cbLab, FieldByName('ID_LAB').AsString);
        cbMapel.ItemIndex := ComboIndex(cbMapel, FieldByName('ID_MAPEL_AMPU').AsString);
        cbHari.ItemIndex  := cbHari.Items.IndexOf(FieldByName('HARI').AsString);
        DTPMulai.Time     := FieldByName('JAM_MULAI').AsDateTime;
        DTPSelesai.Time   := FieldByName('JAM_SELESAI').AsDateTime;

        btnHapus.Enabled := True;
       end
      else
       begin
        form_default;
        btnHapus.Enabled := False;
       end;
     end;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure tampil_hari;
begin
 with f_jadwal_lab do
  begin
   cbHari.Clear;
   cbHari.Items.AddObject('- Pilih Hari', TString_.Create('-'));
   cbHari.Items.AddObject('SENIN', TString_.Create('Senin'));
   cbHari.Items.AddObject('SELASA', TString_.Create('Selasa'));
   cbHari.Items.AddObject('RABU', TString_.Create('Rabu'));
   cbHari.Items.AddObject('KAMIS', TString_.Create('Kamis'));
   cbHari.Items.AddObject('JUMAT', TString_.Create('Jumat'));
   cbHari.Items.AddObject('SABTU', TString_.Create('Sabtu'));
   cbHari.Items.AddObject('MINGGU', TString_.Create('Minggu'));
   cbHari.ItemIndex := 0;
  end;
end;

procedure tampil_laboratorium;
begin
 with f_jadwal_lab do
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

procedure tampil_mapel;
begin
 with f_jadwal_lab do
  begin
   try
    cbMapel.Clear;
    cbMapel.Items.AddObject('- Pilih Mata Pelajaran', TString_.Create('-'));

    with DMServer.ZQEksekusi2 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT A.ID_MAPEL_AMPU AS KODE, CONCAT(B.NM_MAPEL,'' ( '',C.NM_GURU,'' )'') AS NAMA '+
                  'FROM T_MAPEL_AMPU A, T_MAPEL B, T_GURU C '+
                  'WHERE A.ID_MAPEL=B.ID_MAPEL AND A.NO_INDUK_PEGAWAI=C.NO_INDUK_PEGAWAI '+
                  'ORDER BY NM_MAPEL';
      Open;

      while not DMServer.ZQEksekusi2.Eof do
       begin
        cbMapel.Items.AddObject(FieldByName('NAMA').AsString, TString_.Create(FieldByName('KODE').AsString));
        Next;
       end;
     end;
    cbMapel.ItemIndex := 0;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end; 
  end;
end;

procedure tampil_grid(tahun: String);
begin
 if (tahun<>'') then
  begin
   try
    with DMServer.ZQTampil1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT A.ID_JADWAL AS KODE, A.TAHUN_AJAR, B.NM_LAB AS RUANG, '+
                  'CONCAT(D.NM_MAPEL,'' ( '',E.NM_GURU,'' )'') AS MAPEL, '+
                  'CONCAT(A.HARI,'', ( '',A.JAM_MULAI,''-'',A.JAM_SELESAI,'' )'') AS JADWAL '+
                  'FROM T_JADWAL_LAB A, T_LAB B, T_MAPEL_AMPU C, T_MAPEL D, T_GURU E '+
                  'WHERE A.TAHUN_AJAR='+#39+tahun+#39+' AND A.ID_LAB=B.ID_LAB AND '+
                  'A.ID_MAPEL_AMPU=C.ID_MAPEL_AMPU AND C.ID_MAPEL=D.ID_MAPEL AND '+
                  'C.NO_INDUK_PEGAWAI=E.NO_INDUK_PEGAWAI';
      Open;
     end;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_jadwal_lab.FormShow(Sender: TObject);
begin
 DMServer.ZQTampil1.SQL.Clear;
 btnHapus.Enabled := False;
 form_default;
 tampil_hari;
 tampil_laboratorium;
 tampil_mapel;
 DTPTahunChange(Self);
 DTPTahun.SetFocus;
end;

procedure Tf_jadwal_lab.edKodeKeyPress(Sender: TObject; var Key: Char);
begin
 if (Sender=edKode) then
  begin
   if not(Key in['0'..'9', #8, #13]) then
    key:= #0 ;
  end;

 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_jadwal_lab.btnSimpanClick(Sender: TObject);
begin
 if edKode.Text = '' then
  begin
   MessageDlg(edKode.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKode.SetFocus;
  end
 else if DTPSelesai.Time < DTPMulai.Time then
  begin
   MessageDlg(lbSelesai.Caption+' tidak boleh kurang dari '+lbMulai.Caption, mtWarning, [mbOK], 0);
   DTPSelesai.SetFocus;
  end 
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      if btnHapus.Enabled then
       SQL.Text := 'UPDATE T_JADWAL_LAB SET ID_JADWAL='+#39+edKode.Text+#39+','+
                   ' ID_LAB='+#39+TString_(cbLab.Items.Objects[cbLab.ItemIndex]).Str+#39+','+
                   ' ID_MAPEL_AMPU='+#39+TString_(cbMapel.Items.Objects[cbMapel.ItemIndex]).Str+#39+','+
                   ' TAHUN_AJAR='+#39+IntToStr(YearOf(DTPTahun.Date))+#39+','+
                   ' HARI='+#39+TString_(cbHari.Items.Objects[cbHari.ItemIndex]).Str+#39+','+
                   ' JAM_MULAI='+#39+TimeToStr(DTPMulai.Time)+#39+','+
                   ' JAM_SELESAI='+#39+TimeToStr(DTPSelesai.Time)+#39+
                   ' WHERE ID_JADWAL='+#39+ID_JADWAL_LAMA+#39
      else
       SQL.Text := 'INSERT INTO T_JADWAL_LAB VALUES ('+#39+edKode.Text+#39+','+
                                                       #39+TString_(cbLab.Items.Objects[cbLab.ItemIndex]).Str+#39+','+
                                                       #39+TString_(cbMapel.Items.Objects[cbMapel.ItemIndex]).Str+#39+','+
                                                       #39+IntToStr(YearOf(DTPTahun.Date))+#39+','+
                                                       #39+TString_(cbHari.Items.Objects[cbHari.ItemIndex]).Str+#39+','+
                                                       #39+TimeToStr(DTPMulai.Time)+#39+','+
                                                       #39+TimeToStr(DTPSelesai.Time)+#39+')';
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edKode.Clear;
    form_default;
    DTPTahunChange(Self);
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_jadwal_lab.DBGrid1DblClick(Sender: TObject);
begin
 edKode.Text := DBGrid1.Fields[0].AsString;
 form_isi;
end;

procedure Tf_jadwal_lab.btnHapusClick(Sender: TObject);
begin
 if edKode.Text = '' then
  begin
   MessageDlg(edKode.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKode.SetFocus;
  end
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM T_JADWAL_LAB WHERE ID_JADWAL='+#39+edKode.Text+#39;
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edKode.Clear;
    form_default;
    DTPTahunChange(Self);
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_jadwal_lab.edKodeExit(Sender: TObject);
begin
 form_isi;
end;

procedure Tf_jadwal_lab.DTPTahunChange(Sender: TObject);
begin
 tampil_grid(IntToStr(YearOf(DTPTahun.Date)));
end;

procedure Tf_jadwal_lab.cbHariChange(Sender: TObject);
begin
 edKode.Text := IntToStr(YearOf(DTPTahun.Date))+'-'+
                TString_(cbLab.Items.Objects[cbLab.ItemIndex]).Str+'-'+
                TString_(cbMapel.Items.Objects[cbMapel.ItemIndex]).Str+'-'+
                TString_(cbHari.Items.Objects[cbHari.ItemIndex]).Str;
end;

end.
