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
