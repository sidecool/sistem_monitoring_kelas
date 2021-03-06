unit u_guru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, ComCtrls;

type
  Tf_guru = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnTutup: TBitBtn;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    edKode: TLabeledEdit;
    edNama: TLabeledEdit;
    cbJenisKelamin: TComboBox;
    edTempatLahir: TLabeledEdit;
    cbAgama: TComboBox;
    edAlamat: TLabeledEdit;
    edTelp: TLabeledEdit;
    DTPTglLahir: TDateTimePicker;
    lbJenisKelamin: TLabel;
    lbTglLahir: TLabel;
    lbAgama: TLabel;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edKodeKeyPress(Sender: TObject; var Key: Char);
    procedure btnSimpanClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure edKodeExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_guru: Tf_guru;

implementation

uses u_dm, DateUtils, u_server;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_guru.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_guru.btnTutupClick(Sender: TObject);
begin
 Close;
end;

procedure form_default;
begin
 with f_guru do
  begin
   edNama.Clear;
   cbJenisKelamin.ItemIndex := 0;
   edTempatLahir.Clear;
   DTPTglLahir.Date := Now;
   cbAgama.ItemIndex := 0;
   edAlamat.Clear;
   edTelp.Clear;
  end;
end;

procedure form_isi;
var
 JK: String;
begin
 with f_guru do
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM T_GURU WHERE NO_INDUK_PEGAWAI='+#39+edKode.Text+#39;
      Open;

      if FieldByName('NO_INDUK_PEGAWAI').AsString <> '' then
       begin
        if FieldByName('JENIS_KELAMIN').AsString = 'L' then
         JK := 'Laki-laki'
        else if FieldByName('JENIS_KELAMIN').AsString = 'P' then
         JK := 'Perempuan';

        edNama.Text              := FieldByName('NM_GURU').AsString;
        cbJenisKelamin.ItemIndex := cbJenisKelamin.Items.IndexOf(JK);
        edTempatLahir.Text       := FieldByName('TEMPAT_LAHIR').AsString;
        DTPTglLahir.Date         := FieldByName('TGL_LAHIR').AsDateTime;
        cbAgama.ItemIndex        := cbAgama.Items.IndexOf(FieldByName('AGAMA').AsString);
        edAlamat.Text            := FieldByName('ALAMAT').AsString;
        edTelp.Text              := FieldByName('NO_TELP').AsString;

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

procedure Tf_guru.FormShow(Sender: TObject);
begin
 btnHapus.Enabled := False;
 form_default;

 with DMServer.ZQTampil1 do
  begin
   Close;
   SQL.Clear;
   SQL.Text := 'SELECT NO_INDUK_PEGAWAI AS KODE, NM_GURU AS NAMA, TEMPAT_LAHIR, '+
               'DATE_FORMAT(TGL_LAHIR, "%e/%m/%Y") AS TGL_LAHIR, '+
               'CONCAT(TEMPAT_LAHIR,'+#39+', '+#39+',DATE_FORMAT(TGL_LAHIR, "%e/%m/%Y")) AS TTL, '+
               'JENIS_KELAMIN, AGAMA, NO_TELP, SUBSTRING(ALAMAT, 1, 5000) AS ALAMAT '+
               'FROM T_GURU WHERE NO_INDUK_PEGAWAI <> ''XXX99AAA'' ORDER BY NM_GURU';
   Open;
  end;
 edKode.SetFocus;
end;

procedure Tf_guru.edKodeKeyPress(Sender: TObject; var Key: Char);
begin
 if (Sender=edKode) or (Sender=edTelp) then
  begin
   if not(Key in['0'..'9', #8, #13]) then
    key:= #0 ;
  end;

 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_guru.btnSimpanClick(Sender: TObject);
var
 JK: String;
 TNow, TLhr, TSelisih: Integer;
begin
 if cbJenisKelamin.ItemIndex=1 then
  JK := 'L'
 else if cbJenisKelamin.ItemIndex=2 then
  JK := 'P';

 TNow     := YearOf(Now);
 TLhr     := YearOf(DTPTglLahir.Date);
 TSelisih := TNow-TLhr;

 if edKode.Text = '' then
  begin
   MessageDlg(edKode.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKode.SetFocus;
  end
 else if edNama.Text = '' then
  begin
   MessageDlg(edNama.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edNama.SetFocus;
  end
 else if cbJenisKelamin.ItemIndex < 1 then
  begin
   MessageDlg(lbJenisKelamin.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbJenisKelamin.SetFocus;
  end
 else if cbAgama.ItemIndex < 1 then
  begin
   MessageDlg(lbAgama.Caption+' belum dipilih', mtWarning, [mbOK], 0);
   cbAgama.SetFocus;
  end
 else if TSelisih < 20 then
  begin
   MessageDlg(lbTglLahir.Caption+' salah memilih tahun, guru minimal berusia 20', mtWarning, [mbOK], 0);
   DTPTglLahir.SetFocus;
  end
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      if btnHapus.Enabled then
       SQL.Text := 'UPDATE T_GURU SET NM_GURU='+#39+edNama.Text+#39+','+
                   ' TEMPAT_LAHIR='+#39+edTempatLahir.Text+#39+','+
                   ' TGL_LAHIR=STR_TO_DATE('+#39+DateToStr(DTPTglLahir.Date, f_server.fs)+#39+', "%e/%m/%Y")'+','+
                   ' JENIS_KELAMIN='+#39+JK+#39+','+
                   ' AGAMA='+#39+cbAgama.Text+#39+','+
                   ' NO_TELP='+#39+edTelp.Text+#39+','+
                   ' ALAMAT='+#39+edAlamat.Text+#39+
                   ' WHERE NO_INDUK_PEGAWAI='+#39+edKode.Text+#39
      else
       SQL.Text := 'INSERT INTO T_GURU VALUES ('+#39+edKode.Text+#39+','+
                                                 #39+edNama.Text+#39+','+
                                                 #39+edTempatLahir.Text+#39+','+
                                                 'STR_TO_DATE('+#39+DateToStr(DTPTglLahir.Date, f_server.fs)+#39+', "%e/%m/%Y"),'+
                                                 #39+JK+#39+','+
                                                 #39+cbAgama.Text+#39+','+
                                                 #39+edTelp.Text+#39+','+
                                                 #39+edAlamat.Text+#39+')';
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edKode.Clear;
    form_default;
    edKode.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_guru.DBGrid1DblClick(Sender: TObject);
begin
 edKode.Text := DBGrid1.Fields[0].AsString;
 form_isi;
end;

procedure Tf_guru.btnHapusClick(Sender: TObject);
begin
 if edKode.Text = '' then
  begin
   MessageDlg(edKode.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edKode.SetFocus;
  end
 else if edNama.Text = '' then
  begin
   MessageDlg(edNama.EditLabel.Caption+' tidak boleh kosong', mtWarning, [mbOK], 0);
   edNama.SetFocus;
  end
 else
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM T_GURU WHERE NO_INDUK_PEGAWAI='+#39+edKode.Text+#39;
      ExecSQL;
     end;

    DMServer.ZQTampil1.Close;
    DMServer.ZQTampil1.Open;
    btnHapus.Enabled := False;
    edKode.Clear;
    form_default;
    edKode.SetFocus;
   except
    on e: Exception do MessageDlg('Error : '+e.Message, mtError, [mbOK], 0);
   end;
  end;
end;

procedure Tf_guru.edKodeExit(Sender: TObject);
begin
 form_isi;
end;

end.
