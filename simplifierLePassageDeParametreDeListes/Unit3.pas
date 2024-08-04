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
/// Signature : 14e6c82fbaa9fcd222dfcce78b3280342b9c5875
/// ***************************************************************************
/// </summary>

unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, JSON, FMX.Memo.Types;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure ajout_lignes(lignes: TJSONObject; supprimer: boolean = true);
  public
    { Déclarations publiques }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}
{ TForm3 }

procedure TForm3.ajout_lignes(lignes: TJSONObject; supprimer: boolean);
var
  ch1, ch2: string;
  i: integer;
begin
  if assigned(lignes) then
  begin
    for i := 1 to 5 do
    begin
      try
        ch1 := (lignes.GetValue('ligne ' + i.ToString) as TJSONString).Value;
        ch2 := (lignes.GetValue('ligne ' + i.ToString) as TJSONString).ToString;
      except
        ch1 := '';
        ch2 := '';
      end;
      Memo1.Lines.Add(ch1);
      Memo1.Lines.Add(ch2);
    end;
    if supprimer then
      lignes.Free;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  jso: TJSONObject;
begin
  jso := TJSONObject.Create;
  jso.AddPair('ligne 1', 'texte 1');
  jso.AddPair('ligne 2', 'texte 2');
  jso.AddPair('ligne 3', 'texte 3');
  jso.AddPair('ligne 4', 'texte 4');
  jso.AddPair('ligne 5', 'texte 5');
  ajout_lignes(jso);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  ajout_lignes(TJSONObject.Create.AddPair('ligne 1', 'texte 1')
    .AddPair('ligne 2', 'texte 2').AddPair('ligne 3', 'texte 3')
    .AddPair('ligne 4', 'texte 4').AddPair('ligne 5', 'texte 5'));
end;

end.
