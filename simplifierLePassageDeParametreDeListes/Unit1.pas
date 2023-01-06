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
