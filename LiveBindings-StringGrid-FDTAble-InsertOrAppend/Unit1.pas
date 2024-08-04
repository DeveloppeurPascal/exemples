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
/// Signature : 28a88bd657ff03c4007f38accd83ab624a1e0280
/// ***************************************************************************
/// </summary>

unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, Data.Bind.Controls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.StdCtrls, FMX.Layouts,
  Fmx.Bind.Navigator, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    BindNavigator1: TBindNavigator;
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    btnAppend: TButton;
    btnInsert: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnAppendClick(Sender: TObject);
  private
    { Déclarations privées }
    FCreateDatabase: Boolean;
    function getDatabaseFilePath: string;
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses System.IOUtils;

procedure TForm1.btnAppendClick(Sender: TObject);
begin
  FDTable1.Append;
end;

procedure TForm1.btnInsertClick(Sender: TObject);
begin
  FDTable1.Insert;
end;

procedure TForm1.FDConnection1AfterConnect(Sender: TObject);
begin
  if FCreateDatabase then
  begin
    FDConnection1.execsql('CREATE TABLE MyTable (' +
      'NewField INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,' +
      'libelle VARCHAR(50) NULL);');
    for var i := 1 to 50 do
      FDConnection1.execsql('insert into MyTable (libelle) values(:lib)',
        ['Hello' + i.ToString]);
  end;
  FDTable1.Open;
end;

procedure TForm1.FDConnection1BeforeConnect(Sender: TObject);
begin
  FCreateDatabase := not tfile.exists(getDatabaseFilePath);
  FDConnection1.Params.Clear;
  FDConnection1.Params.AddPair('DriverID', 'SQLite');
  FDConnection1.Params.AddPair('LockingMode', 'Normal');
  FDConnection1.Params.AddPair('Database', getDatabaseFilePath);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not FDConnection1.Connected then
    FDConnection1.Open
end;

function TForm1.getDatabaseFilePath: string;
begin
  result := tpath.combine(tpath.GetDirectoryName(paramstr(0)),
    tpath.GetFileNameWithoutExtension(paramstr(0)) + 'db');
end;

end.
