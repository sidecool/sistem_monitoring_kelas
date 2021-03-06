unit u_lab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  Tf_lab = class(TForm)
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
  f_lab: Tf_lab;

implementation

uses u_dm, ZDataset, DB, ZAbstractRODataset;

{$R *.dfm}

procedure keyenter_next(var Key: Char);
begin
 if Key = #13 then
  begin
   Key := #0;
   f_lab.Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tf_lab.btnTutupClick(Sender: TObject);
begin
 Close
end;

procedure form_default;
begin
 with f_lab do
  begin
   edNama.Clear;
  end;
end;

procedure form_isi;
begin
 with f_lab do
  begin
   try
    with DMServer.ZQEksekusi1 do
     begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM T_LAB WHERE ID_LAB='+#39+edKode.Text+#39;
      Open;

      if FieldByName('ID_LAB').AsString <> '' then
       begin
        edNama.Text := FieldByName('NM_LAB').AsString;

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

procedure Tf_lab.FormShow(Sender: TObject);
begin
 btnHapus.Enabled := False;
 form_default;

 with DMServer.ZQTampil1 do
  begin
   Close;
   SQL.Clear;
   SQL.Text := 'SELECT ID_LAB AS KODE, NM_LAB AS NAMA FROM T_LAB ORDER BY ID_LAB';
   Open;
  end;
 edKode.SetFocus;
end;

procedure Tf_lab.edKodeKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  keyenter_next(Key)
end;

procedure Tf_lab.btnSimpanClick(Sender: TObject);
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
       SQL.Text := 'UPDATE T_LAB SET NM_LAB='+#39+edNama.Text+#39+' WHERE ID_LAB='+#39+edKode.Text+#39
      else
       SQL.Text := 'INSERT INTO T_LAB VALUES ('+#39+edKode.Text+#39+','+#39+edNama.Text+#39+')';
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

procedure Tf_lab.DBGrid1DblClick(Sender: TObject);
begin
 edKode.Text := DBGrid1.Fields[0].AsString;
 form_isi;
end;

procedure Tf_lab.btnHapusClick(Sender: TObject);
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
      SQL.Text := 'DELETE FROM T_LAB WHERE ID_LAB='+#39+edKode.Text+#39;
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

procedure Tf_lab.edKodeExit(Sender: TObject);
begin
 form_isi;
end;

end.
