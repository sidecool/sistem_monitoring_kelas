unit u_kelas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  Tf_kelas = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    edKode: TLabeledEdit;
    edNama: TLabeledEdit;
    Panel1: TPanel;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnTutup: TBitBtn;
    DBGrid1: TDBGrid;
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
  f_kelas: Tf_kelas;

implementation

uses u_dm, ZDataset, DB, ZAbstractRODataset;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_kelas.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_kelas.btnTutupClick(Sender: TObject);
begin
 Close
end;

procedure form_default;
begin
 with f_kelas do
  begin
   edNama.Clear;
  end;
end;

procedure form_isi;
begin
 with f_kelas do
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM T_KELAS WHERE ID_KELAS='+#39+edKode.Text+#39;
      Open;

      if FieldByName('ID_KELAS').AsString <> '' then
       begin
        edNama.Text := FieldByName('NM_KELAS').AsString;

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

procedure Tf_kelas.FormShow(Sender: TObject);
begin
 btnHapus.Enabled := False;
 form_default;

 with DMServer.ZQTampil1 do
  begin
   Close;
   SQL.Clear;
   SQL.Text := 'SELECT ID_KELAS AS KODE, NM_KELAS AS NAMA FROM T_KELAS ORDER BY ID_KELAS';
   Open;
  end;
 edKode.SetFocus;
end;

procedure Tf_kelas.edKodeKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_kelas.btnSimpanClick(Sender: TObject);
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
      if btnHapus.Enabled then
       SQL.Text := 'UPDATE T_KELAS SET NM_KELAS='+#39+edNama.Text+#39+' WHERE ID_KELAS='+#39+edKode.Text+#39
      else
       SQL.Text := 'INSERT INTO T_KELAS VALUES ('+#39+edKode.Text+#39+','+#39+edNama.Text+#39+')';
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

procedure Tf_kelas.DBGrid1DblClick(Sender: TObject);
begin
 edKode.Text := DBGrid1.Fields[0].AsString;
 form_isi;
end;

procedure Tf_kelas.btnHapusClick(Sender: TObject);
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
      SQL.Text := 'DELETE FROM T_KELAS WHERE ID_KELAS='+#39+edKode.Text+#39;
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

procedure Tf_kelas.edKodeExit(Sender: TObject);
begin
 form_isi;
end;

end.
