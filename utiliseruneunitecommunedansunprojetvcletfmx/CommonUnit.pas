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
/// Signature : edb4848497ec39551f6a0c2819d14f14f4f39dd5
/// ***************************************************************************
/// </summary>

unit CommonUnit;

interface

// use this code
{$IFDEF VCL}
{$MESSAGE 'Application VCL'}
{$ELSE}
{$IFDEF FMX}
{$MESSAGE 'Application FMX'}
{$ELSE}
{$IFDEF CONSOLE}
{$MESSAGE 'Application console'}
{$ELSE}
{$MESSAGE FATAL 'Please define VCL, FMX or CONSOLE in your project.'}
{$ENDIF}
{$ENDIF}
{$ENDIF}

// or this one
{$IF not (Defined(VCL) or Defined(FMX) or Defined(CONSOLE))}
{$MESSAGE FATAL 'Please define VCL, FMX or CONSOLE in your project.'}
{$ENDIF}

procedure AfficheMessage(texte: string);

implementation

{$IF Defined(VCL)}

uses VCL.Dialogs;
{$ELSEIF Defined(FMX)}

uses FMX.Dialogs;
{$ENDIF}

procedure AfficheMessage(texte: string);
begin
{$IF Defined(VCL) or Defined(FMX)}
  ShowMessage(texte);
{$ELSEIF Defined(CONSOLE)}
  writeln(texte);
{$ENDIF}
end;

end.
