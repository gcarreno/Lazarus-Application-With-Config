unit ACD.Forms.Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, Menus,
  StdActns, IniPropStorage, ExtCtrls, StdCtrls;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    aclMain: TActionList;
    actFileExit: TFileExit;
    iniConfigMain: TIniPropStorage;
    mnuFileExit: TMenuItem;
    mnuFile: TMenuItem;
    mnuMain: TMainMenu;
    procedure FormCreate(Sender: TObject);
  private
    procedure InitShortCuts;
    procedure InitConfig;
  public

  end;

var
  frmMain: TfrmMain;

implementation

uses
  LCLType;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  InitConfig;
  InitShortCuts;
end;

procedure TfrmMain.InitShortCuts;
begin
// For the VK_* consts to work, we need unit LCLType
{$IFDEF LINUX}
  actFileExit.ShortCut := KeyToShortCut(VK_Q, [ssCtrl]);
{$ENDIF}
{$IFDEF WINDOWS}
  actFileExit.ShortCut := KeyToShortCut(VK_X, [ssAlt]);
{$ENDIF}
end;

procedure TfrmMain.InitConfig;
begin
  // The INI section on the file, kinda spoils it on the name ;)
  iniConfigMain.IniSection:= 'Application';

  // GetAppConfigFile will return <AppName>.cfg in the appropriate folder
  iniConfigMain.IniFileName:= GetAppConfigFile(False);
  {
   You also have:
     GetAppConfigFile(Global: Boolean; SubDir: Boolean)
   if you want to have the config file in it's own sub folder.
   Comes in handy when you want to drop more than one config file.
   Also:
     GetAppConfigDir(Global:Boolean)
   if you only want the folder.

   This all works seemingly for Windows/Linux/MacOS
  }
end;

end.

