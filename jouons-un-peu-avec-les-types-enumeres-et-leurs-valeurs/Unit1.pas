unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TForm1 = class(TForm)
    FlowLayout1: TFlowLayout;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    btnGetID: TButton;
    btnGetFruit: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGetIDClick(Sender: TObject);
    procedure btnGetFruitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure ButtonAdd(Text: String; Tag: Integer);
    procedure ButtonFruitClick(Sender: TObject);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.TypInfo;

type
  TFruits = (Orange, Pomme, Banane, Peche, Pasteque, Pamplemousse);

  TFruitsConst = (OrangeConst = 3, PommeConst = 18, BananeConst = 15,
    PecheConst = 0, PastequeConst = 12, PamplemousseConst = 7);

type
  TCorbeilleDeFruits = set of TFruits;

procedure TForm1.btnGetFruitClick(Sender: TObject);
var
  id: Integer;
  fruit: TFruits;
  ok: boolean;
begin
  try
    id := GetEnumValue(typeinfo(TFruits), Edit1.Text);
    ok := false;
    for fruit := low(TFruits) to high(TFruits) do
      if ord(fruit) = id then
      begin
        ok := true;
        break;
      end;
    if ok then
      ButtonAdd(getenumname(typeinfo(TFruits), ord(fruit)), ord(fruit));
  except
    showmessage('fruit defendu');
  end;
end;

procedure TForm1.btnGetIDClick(Sender: TObject);
var
  id: Integer;
begin
  try
    id := GetEnumValue(typeinfo(TFruits), Edit1.Text);
    if (id < 0) then
      showmessage('fruit inconnu') // ID = -1
    else
      showmessage('ID ' + id.ToString);
  except
    showmessage('fruit defendu');
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  fruit, trouve: TFruitsConst;
  id: Integer;
begin
  fruit := TFruitsConst.BananeConst;
  id := ord(fruit);
  showmessage(id.ToString);
  for fruit := low(TFruitsConst) to high(TFruitsConst) do
  begin
    if (ord(fruit) = id) then
    begin
      trouve := fruit;
      break;
    end;
  end;
  showmessage(ord(trouve).ToString);
end;

procedure TForm1.ButtonAdd(Text: String; Tag: Integer);
var
  btn: TButton;
begin
  btn := TButton.Create(Self);
  try
    btn.Parent := FlowLayout1;
    btn.Text := Text;
    btn.Tag := Tag;
    btn.OnClick := ButtonFruitClick;
    btn.Margins.Top := 5;
    btn.Margins.Right := 5;
    btn.Margins.Bottom := 5;
    btn.Margins.Left := 5;
    btn.Width := btn.Width * 2;
  except
    FreeAndNil(btn);
  end;
end;

procedure TForm1.ButtonFruitClick(Sender: TObject);
var
  btn: TButton;
begin
  if (Sender is TButton) then
  begin
    btn := Sender as TButton;
    showmessage('ID ' + btn.Tag.ToString);
    Edit1.Text := btn.Text;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  fruit: TFruits;
begin
  for fruit := low(TFruits) to high(TFruits) do
  begin
    ButtonAdd(getenumname(typeinfo(TFruits), ord(fruit)), ord(fruit));
  end;
  FlowLayout1.AddObject(tflowlayoutbreak.Create(Self));
  for fruit in [Orange, Peche, Pamplemousse] do
  begin
    ButtonAdd(getenumname(typeinfo(TFruits), ord(fruit)), ord(fruit));
  end;
  FlowLayout1.AddObject(tflowlayoutbreak.Create(Self));
end;

end.
