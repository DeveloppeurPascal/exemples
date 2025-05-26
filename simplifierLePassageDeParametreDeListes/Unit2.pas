(* C2PP
  ***************************************************************************

  Developpeur Pascal Blog Sample Projects

  Copyright 2015-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/exemples

  ***************************************************************************
  File last update : 2025-02-09T11:12:34.078+01:00
  Signature : 7e9038dd3f6a3c0d2e20e7aaea3e4a60b4f3aaee
  ***************************************************************************
*)

unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, JSON,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Memo.Types;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure ajout_lignes(lignes: TJSONArray; supprimer: boolean = true);
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.ajout_lignes(lignes: TJSONArray; supprimer: boolean);
var
  i: integer;
begin
  if assigned(lignes) then
  begin
    if (lignes.Count > 0) then
      for i := 0 to lignes.Count - 1 do
      begin
        Memo1.Lines.Add(lignes.Items[i].Value);
        Memo1.Lines.Add(lignes.Items[i].tostring);
      end;
    if supprimer then
      lignes.Free;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  jsa: TJSONArray;
begin
  jsa := TJSONArray.Create;
  jsa.Add('ligne 1');
  jsa.Add('ligne 2');
  jsa.Add('ligne 3');
  jsa.Add('ligne 4');
  jsa.Add('ligne 5');
  ajout_lignes(jsa);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ajout_lignes(TJSONArray.Create.Add('ligne 1').Add('ligne 2').Add('ligne 3')
    .Add('ligne 4').Add('ligne 5'));
end;

end.
