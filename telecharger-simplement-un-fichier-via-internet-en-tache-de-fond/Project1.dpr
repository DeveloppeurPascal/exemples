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
/// Patrick PREMARTIN
///
/// Site :
/// https://developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/exemples
///
/// ***************************************************************************
/// File last update : 2024-09-17T10:57:20.000+02:00
/// Signature : 745581c0bdb84201bf8749a8acfb3d18df5c3089
/// ***************************************************************************
/// </summary>

program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  unit1 in 'unit1.pas' {Form1},
  u_download in '..\Libraries\librairies\src\u_download.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
