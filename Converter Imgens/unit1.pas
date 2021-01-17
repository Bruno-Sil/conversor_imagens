unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    private

    public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenPictureDialog1.Options:=OpenPictureDialog1.Options+[ofFileMustExist];
  if not OpenPictureDialog1.Execute then exit;
  try
    Image1.Picture.LoadFromFile(OpenPictureDialog1.Filename);

  except
    on E: Exception do begin
      MessageDlg('Error','Error: '+E.Message,mtError,[mbOk],0);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
  var
    JPEG: TJPEGImage;
  begin
    if Image1.Picture.Graphic=nil then begin
      MessageDlg('No image','Please open an image, before save',mtError,
        [mbOk],0);
      exit;
    end;

    SavePictureDialog1.Options:=SavePictureDialog1.Options+[ofPathMustExist];
    if not SavePictureDialog1.Execute then exit;
    try
      JPEG:=TJPEGImage.Create;
      try
        JPEG.Assign(Image1.Picture.Graphic);
        JPEG.SaveToFile(SavePictureDialog1.Filename);
      finally
        JPEG.Free;
      end;

    except
      on E: Exception do begin
        MessageDlg('Error','Error: '+E.Message,mtError,[mbOk],0);
      end;
    end;
  end;


end.

