unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.TreeView,
  FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Memo.Types;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    Button1: TButton;
    Memo1: TMemo;
    Rectangle1: TRectangle;
    procedure Button1Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1DragChange(SourceItem, DestItem: TTreeViewItem; var Allow: Boolean);
    procedure TreeView1DragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
    procedure TreeView1DragEnd(Sender: TObject);
    procedure TreeView1DragEnter(Sender: TObject; const Data: TDragObject; const Point: TPointF);
    procedure TreeView1DragLeave(Sender: TObject);
    procedure TreeView1DragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF;
      var Operation: TDragOperation);
    procedure TreeViewItemDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
  private
    { Déclarations privées }
    ItemNumber: integer;
    procedure generate_datas(node: TTreeViewItem = nil; profondeur: integer = 1);
    procedure affiche(text: string);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

var
  previous: string = '';

procedure TForm1.affiche(text: string);
begin
  if (previous <> text) then
  begin
    Memo1.lines.add(text);
    Memo1.GoToTextEnd;
    previous := text;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ItemNumber := 0;
  generate_datas(nil, 5);
end;

procedure TForm1.generate_datas(node: TTreeViewItem; profondeur: integer);
var
  item: TTreeViewItem;
  i, nb: integer;
begin
  if (profondeur > 0) then
  begin
    nb := random(10);
    for i := 0 to nb do
    begin
      inc(ItemNumber);
      item := TTreeViewItem.Create(Self);
      item.text := 'Item : ' + ItemNumber.ToString;
      item.OnDragDrop := TreeViewItemDragDrop;
      if assigned(node) then
        node.AddObject(item)
      else
        TreeView1.AddObject(item);
      generate_datas(item, profondeur - 1);
    end;
  end;
end;

procedure TForm1.TreeView1Click(Sender: TObject);
begin
  if (TreeView1.Selected.IsExpanded) then
    TreeView1.Selected.collapse
  else if TreeView1.Selected.Count > 0 then
    TreeView1.Selected.expand;
end;

procedure TForm1.TreeView1DragChange(SourceItem, DestItem: TTreeViewItem; var Allow: Boolean);
begin
  affiche('TreeView1DragChange');
  Allow := true;
end;

procedure TForm1.TreeView1DragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
begin
  affiche('TreeView1DragDrop');
end;

procedure TForm1.TreeView1DragEnd(Sender: TObject);
begin
  affiche('TreeView1DragEnd');
end;

procedure TForm1.TreeView1DragEnter(Sender: TObject; const Data: TDragObject; const Point: TPointF);
begin
  affiche('TreeView1DragEnter');
end;

procedure TForm1.TreeView1DragLeave(Sender: TObject);
begin
  affiche('TreeView1DragLeave');
end;

procedure TForm1.TreeView1DragOver(Sender: TObject; const Data: TDragObject; const Point: TPointF;
  var Operation: TDragOperation);
begin
  affiche('TreeView1DragOver');
  Operation := TDragOperation.Move;
end;

procedure TForm1.TreeViewItemDragDrop(Sender: TObject; const Data: TDragObject; const Point: TPointF);
begin
  if Sender is TTreeViewItem then
    affiche('TreeViewItemDragDrop : ' + (Sender as TTreeViewItem).text);
end;

end.
