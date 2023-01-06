unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FMX.Controls.Presentation, FMX.Edit, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    Sqlite_demoConnection: TFDConnection;
    EmployeesTable: TFDQuery;
    Edit1: TEdit;
    procedure EmployeesTableAfterOpen(DataSet: TDataSet);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.EmployeesTableAfterOpen(DataSet: TDataSet);
var
  item: TListViewItem;
begin
  EmployeesTable.First;
  while not EmployeesTable.Eof do
  begin
    item := ListView1.Items.Add;
    item.Text := EmployeesTable.FieldByName('Lastname').AsString;
    item.Tag := EmployeesTable.FieldByName('EmployeeID').AsInteger;
    EmployeesTable.Next;
  end;
end;

procedure TForm1.ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  if EmployeesTable.Locate('EmployeeID', ListView1.Items[ItemIndex].Tag) then
    Edit1.Text := EmployeesTable.FieldByName('Lastname').AsString;
end;

end.
