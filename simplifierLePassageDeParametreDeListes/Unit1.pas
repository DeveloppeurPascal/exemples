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
/// Signature : c478684feadf591a99d12ed784c6fa4182ec88d2
/// ***************************************************************************
/// </summary>

unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure ajout_lignes(lignes: tstrings; supprimer: boolean = true);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

type
  TMyStringListHelper = class helper for TStringList
    function ajoute(ch: string): TStringList;
  end;

type
  TMyStringList = class(TStringList)
    function ajoute(ch: string): TStringList;
  end;

procedure TForm1.ajout_lignes(lignes: tstrings; supprimer: boolean = true);
var
  ch: string;
begin
  if assigned(lignes) then
  begin
    if (lignes.Count > 0) then
      for ch in lignes do
        Memo1.Lines.Add(ch);
    if supprimer then
      lignes.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lignes: TStringList;
begin
  lignes := TStringList.Create;
  lignes.Add('ligne 1');
  lignes.Add('ligne 2');
  lignes.Add('ligne 3');
  lignes.Add('ligne 4');
  lignes.Add('ligne 5');
  ajout_lignes(lignes);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ajout_lignes(TStringList.Create.ajoute('ligne 1').ajoute('ligne 2')
    .ajoute('ligne 3').ajoute('ligne 4').ajoute('ligne 5'));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ajout_lignes(TMyStringList.Create.ajoute('ligne 1').ajoute('ligne 2')
    .ajoute('ligne 3').ajoute('ligne 4').ajoute('ligne 5'));
end;

{ TMyStringListHelper }

function TMyStringListHelper.ajoute(ch: string): TStringList;
begin
  Add(ch);
  Result := Self;
end;

{ TMyStringList }

function TMyStringList.ajoute(ch: string): TStringList;
begin
  Add(ch);
  Result := Self;
end;

end.
