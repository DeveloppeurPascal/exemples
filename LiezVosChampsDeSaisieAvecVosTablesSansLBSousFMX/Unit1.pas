/// <summary>
/// ***************************************************************************
///
/// Samples from blog D�veloppeur Pascal
///
/// Copyright 2017-2024 Patrick Pr�martin under AGPL 3.0 license.
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
/// Signature : e8fc8c79edc27bc5a11590d145be3b0d03983aaa
/// ***************************************************************************
/// </summary>

unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Rtti, FMX.Grid.Style,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.ScrollBox, FMX.Grid;

type
  TForm1 = class(TForm)
    FDMemTable1: TFDMemTable;
    FDMemTable1id: TAutoIncField;
    FDMemTable1f1: TBooleanField;
    FDMemTable1f2: TBooleanField;
    FDMemTable1f3: TBooleanField;
    btnInsert: TButton;
    btnPost: TButton;
    btnCancel: TButton;
    EDT_Tab_id: TEdit;
    CB_Tab_f1: TCheckBox;
    CB_Tab_f2: TCheckBox;
    CB_Tab_f3: TCheckBox;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure btnInsertClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure StringGrid1SelChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { D�clarations priv�es }
    function getFieldName(ComponentName: string): string;
    procedure ScreenToDB;
    procedure DBToScreen;
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnInsertClick(Sender: TObject);
begin
  FDMemTable1.Insert;
  DBToScreen;
end;

procedure TForm1.btnPostClick(Sender: TObject);
begin
  ScreenToDB;
  FDMemTable1.Post;
end;

procedure TForm1.DBToScreen;
var
  i: integer;
  fieldname: string;
begin
  for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TEdit) then
        begin
          fieldname := getFieldName(Components[i].Name);
          if (fieldname.Length > 0) then
            (Components[i] as TEdit).Text :=
              FDMemTable1.FieldByName(fieldname).AsString;
        end
      else if (Components[i] is TCheckBox) then
        begin
          fieldname := getFieldName(Components[i].Name);
          if (fieldname.Length > 0) then
            (Components[i] as TCheckBox).IsChecked :=
              FDMemTable1.FieldByName(fieldname).AsBoolean;
        end;
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDMemTable1.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDMemTable1.Open;
end;

function TForm1.getFieldName(ComponentName: string): string;
var
  tab: tarray<string>;
  i: integer;
  first: boolean;
begin
  result := '';
  tab := ComponentName.split(['_']);
  first := true;
  if (Length(tab) > 2) and (tab[1].tolower = 'tab') then
    for i := 2 to Length(tab) - 1 do
      if first then
        begin
          result := tab[i];
          first := false;
        end
      else
        result := result + '_' + tab[i];
end;

procedure TForm1.ScreenToDB;
var
  i: integer;
  fieldname: string;
begin
  for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TEdit) then
        begin
          if (not(Components[i] as TEdit).readonly) then
            begin
              fieldname := getFieldName(Components[i].Name);
              if (fieldname.Length > 0) then
                FDMemTable1.FieldByName(fieldname).AsString :=
                  (Components[i] as TEdit).Text;
            end;
        end
      else if (Components[i] is TCheckBox) then
        begin
          fieldname := getFieldName(Components[i].Name);
          if (fieldname.Length > 0) then
            FDMemTable1.FieldByName(fieldname).AsBoolean :=
              (Components[i] as TCheckBox).IsChecked;
        end;
    end;
end;

procedure TForm1.StringGrid1SelChanged(Sender: TObject);
begin
  if (StringGrid1.Row >= 0) and (not FDMemTable1.Eof) then
    DBToScreen;
end;

end.
