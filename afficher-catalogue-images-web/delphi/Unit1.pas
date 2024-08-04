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
/// Signature : 879d2d391613ae184e0174bb772d79158d2341ed
/// ***************************************************************************
/// </summary>

unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    btnChargeImages: TButton;
    StatusBar1: TStatusBar;
    lblStatus: TLabel;
    VertScrollBox1: TVertScrollBox;
    procedure btnChargeImagesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    procedure traiter_liste(url_json: string);
    procedure traiter_image(url_image: string; num: integer);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses u_download, json, System.IOUtils, FMX.Objects;

procedure TForm1.btnChargeImagesClick(Sender: TObject);
begin
  btnChargeImages.Enabled := false;
  traiter_liste
    ('http://127.0.0.1/edsa-web/blogs/afficher-catalogue-images-web/');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  lblStatus.Text := '';
  btnChargeImages.SetFocus;
end;

procedure TForm1.traiter_image(url_image: string; num: integer);
var
  img_name: string;
begin
  img_name := tdownload_file.temporaryFileName('test-photo-' + num.ToString);
  lblStatus.Text := 'Chargement de l''image ' + url_image;
  Application.ProcessMessages;
  tdownload_file.download(url_image, img_name,
    procedure
    var
      img: timage;
    begin
      lblStatus.Text := 'Affichage de l''image ' + url_image;
      Application.ProcessMessages;
      img := timage.Create(Self);
      try
        img.Parent := VertScrollBox1;
        img.Align := TAlignLayout.Top;
        img.Height := 200;
        img.Margins.Top := 5;
        img.Margins.Bottom := 5;
        img.Bitmap.LoadFromFile(img_name);
        // showmessage(img_name);
        // tfile.Delete(img_name);
      except
        if assigned(img) then
          img.Free;
      end;
    end,
    procedure
    begin
      lblStatus.Text := 'Chargement de ' + url_image + ' impossible.';
      Application.ProcessMessages;
      // showmessage(img_name);
      // tfile.Delete(img_name);
    end);
end;

procedure TForm1.traiter_liste(url_json: string);
var
  nom_fichier_json: string;
begin
  lblStatus.Text := 'Chargement de la liste des images.';
  Application.ProcessMessages;
  nom_fichier_json := tdownload_file.temporaryFileName('test-json');
  tdownload_file.download(url_json, nom_fichier_json,
    procedure
    var
      jso: TJSONObject;
      liste: TJSONArray;
      i: integer;
    begin
      try
        lblStatus.Text := 'Liste chargée.';
        Application.ProcessMessages;
        try
          jso := TJSONObject.ParseJSONValue(tfile.ReadAllText(nom_fichier_json,
            TEncoding.UTF8)) as TJSONObject;
          if assigned(jso) then
          begin
            liste := jso.GetValue('liste') as TJSONArray;
            for i := 0 to liste.Count - 1 do
              traiter_image(liste.Items[i].Value, i);
          end;
        finally
          if assigned(jso) then
            jso.Free;
        end;
      finally
        // showmessage(nom_fichier_json);
        // tfile.Delete(nom_fichier_json);
      end;
    end,
    procedure
    begin
      lblStatus.Text := 'Erreur au chargement de la liste des images.';
      Application.ProcessMessages;
      // showmessage(nom_fichier_json);
      // tfile.Delete(nom_fichier_json);
    end);
end;

end.
