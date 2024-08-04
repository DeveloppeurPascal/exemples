/// <summary>
/// ***************************************************************************
///
/// Samples from blog Développeur Pascal
///
/// Copyright 2017-2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// Author(s) :
///      Patrick PREMARTIN
///
/// Site :
///      https://developpeur-pascal.fr/
///
/// Project site :
///      https://github.com/DeveloppeurPascal/exemples
///
/// ***************************************************************************
/// File last update : 30/05/2024 20:10:15
/// Signature : cf68c1fa7d901a503edfc4196bbe6456f5f970e0
/// ***************************************************************************
/// </summary>

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
