unit Book;

interface

 uses ComCtrls, Controls,  SysUtils, LastFileController,Menus,Classes,Chart;

 type

 TBook = class (TPageControl)
   private
     CurrentDocNum : integer;
     FileLast:TLastFileController;
     Chart:TChart;
     procedure ClickOpen(Sender : TObject);
     procedure SetPlotState (plotted:boolean);
     function GetPlotState:boolean;
   public
     constructor Create(AOwner: TWinControl;AddMenuItem: TMenuItem; Chart:TChart);
     procedure NewDocument;
     procedure OpenDocument;
     procedure OpenDocumentAs(FileName : string);
     procedure SaveDocument;
     procedure SaveAsDocument;
     procedure CloseDocument;
     procedure Close;
     procedure AddPoint;
     procedure DelPoint;
     procedure Clear;
     procedure BuildLine;
     property IsActiveDocumentPlotted:boolean read GetPlotState write SetPlotState;
 end;

implementation

uses Document;

constructor TBook.Create(AOwner: TWinControl; AddMenuItem: TMenuItem; Chart:TChart);
var i:Integer; Doc : TDocument;
  begin
    inherited Create(AOwner);
    self.Chart := Chart;
    Parent := AOwner;
    Align := alClient;
    CurrentDocNum := 0;
    FileLast:=TLastFileController.Create(AddMenuItem, ClickOpen);
  end;

procedure TBook.NewDocument;
 var Doc : TDocument;
  begin
    Doc:= TDocument.Create(self, FileLast, Chart);
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

procedure TBook.OpenDocumentAs(FileName : string);
  begin
    try
      NewDocument;
      TDocument(ActivePage).OpenAs(FileName);
    except
      CloseDocument;
    end;
  end;

procedure TBook.SaveDocument;
  begin
   if PageCount > 0 then TDocument(ActivePage).Save;
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
  while PageCount > 0 do CloseDocument;
end;

procedure TBook.ClickOpen(Sender : TObject);
begin
  OpenDocumentAs(FileLast.GetFullName(TMenuItem(Sender).Tag));
end;

procedure TBook.AddPoint;
begin
   if (ActivePage <> nil) then
   TDocument(ActivePage).AddPoint;
end;

procedure TBook.DelPoint;
begin
   if (ActivePage <> nil) then
   TDocument(ActivePage).DelPoint;
end;

procedure TBook.Clear;
begin
   if (ActivePage <> nil) then
   TDocument(ActivePage).Clear;
end;

procedure TBook.BuildLine;
begin
   if (ActivePage <> nil) then
   TDocument(ActivePage).BuildLine;
end;

procedure TBook.SetPlotState(plotted:boolean);
begin
     if (ActivePage <> nil) then
     TDocument(ActivePage).Plotted := plotted;
end;

function TBook.GetPlotState:boolean;
begin
     if (ActivePage <> nil) then
     GetPlotState := TDocument(ActivePage).Plotted
     else GetPlotState := false;
end;

end.
