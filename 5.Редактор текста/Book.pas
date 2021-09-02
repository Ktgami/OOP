unit Book;

interface

 uses ComCtrls, Controls,  SysUtils, LastFileController,Menus;

 type

 TBook = class (TPageControl)
   private
     CurrentDocNum : integer;
     public
     FileLast:TLastFileController;
     constructor Create(AOwner: TWinControl;AddMenuItem: TMenuItem);
     procedure NewDocument;
     procedure OpenDocument;
     procedure SaveDocument;
     procedure SaveAsDocument;
     procedure CloseDocument;
     procedure Close;
 end;

implementation
uses Document;

constructor TBook.Create(AOwner: TWinControl; AddMenuItem: TMenuItem);
var i:Integer; Doc : TDocument;
  begin
    inherited Create(AOwner);
    Parent := AOwner;
    CurrentDocNum := 0;
    FileLast:=TLastFileController.Create(AddMenuItem);
  end;

procedure TBook.NewDocument;
 var Doc : TDocument;
  begin
    Doc:= TDocument.Create(self, FileLast);
    Doc.PageControl := self;
    inc(CurrentDocNum);
    Doc.Name := 'Document_' + IntToStr(CurrentDocNum);
    ActivePage := Doc;
    //FileLast.AddItem(Doc.Name);
  end;

procedure TBook.OpenDocument;
  begin
    NewDocument;
    TDocument(ActivePage).Open;
  end;

procedure TBook.SaveDocument;
  begin
   if PageCount > 0 then begin
    TDocument(ActivePage).Save;
    end;

  end;

procedure TBook.SaveAsDocument;
  begin
   if PageCount > 0 then TDocument(ActivePage).SaveAs;
  end;

procedure TBook.CloseDocument;
begin
  if PageCount > 0 then ActivePage.Destroy;
end;

procedure TBook.Close;
begin
  FileLast.Destroy;
end;

end.
