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
    //   procedure SetPlotStateaprox (plottedaprox:boolean);
//     function GetPlotStateaprox:boolean;
   public
     K:integer;
     constructor Create(AOwner: TWinControl;AddMenuItem: TMenuItem; Chart:TChart);
     procedure NewDocument;
     procedure BuildApproximation;
     procedure OpenDocument;
     procedure OpenDocumentAs(FileName : string);
     procedure SaveDocument;
     procedure SaveAsDocument;
     procedure CloseDocument;
     procedure Close;
     procedure AddPoint;
     procedure DelPoint;
     procedure Clear;
     procedure Settings(temp:boolean);
     procedure aproxSettings;
     procedure BuildLine;
    procedure ClickOnenter(sender:tobject);
     procedure typeaprox(name_LV:string);
    // procedure settings;
     procedure POwerMNK (p:Integer);
//     function aproxplotted:Boolean;
     procedure aproxplottedsET(plotted_LV:boolean);
     function aproxplottedgET:boolean;
     property aproxPlottedBook:Boolean read aproxplottedgET write aproxplottedsET;
     property IsActiveDocumentPlotted:boolean read GetPlotState write SetPlotState;
 //    property IsActiveDocumentAproxPlotted:boolean read GetPlotStateAprox write SetPlotStateAprox;
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
    Doc:= TDocument.Create(self, FileLast, Chart,ClickOnenter);
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
procedure Tbook.BuildApproximation;
begin
//   (ActivePage as TDocument).BuildApproximation;
   
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

procedure Tbook.aproxplottedsET(plotted_LV:boolean);
begin
 if (ActivePage <> nil) then
     TDocument(ActivePage).plottedAprox :=plotted_LV;
end;
function Tbook.aproxplottedGET:Boolean;
begin
   if (ActivePage <> nil) then
  result:=TDocument(ActivePage).plottedAprox
  else result := false;
end;
 procedure Tbook.typeaprox(name_LV:string);
 begin
   TDocument(ActivePage).TypeAprox(name_LV);
 end;
 procedure Tbook.POwerMNK (p:Integer);
 begin
   TDocument(ActivePage).Mnkpower(p);
 end;
procedure Tbook.ClickonEnter(sender:tobject);
 begin
    TDocument(ActivePage).UpdateData;
    if  TDocument(ActivePage).plottedAprox  then begin
   Tdocument(Activepage).OnSelectCellActionAP;
  // chart.SetSettings(Tdocument(ActivePage).getIDA);
  // chart.settings(Tdocument(ActivePage).getIDA,false)
   //перерисовать апроксимацию

     end;
     if  TDocument(ActivePage).plotted then begin
     Tdocument(Activepage).OnSelectCellAction;
   //  chart.SetSettings(Tdocument(ActivePage).getID);     //перерисовать линия
  //   TDocument(ActivePage).plotted :=false;
   ///  TDocument(ActivePage).plotted :=true;
   // chart.settings(Tdocument(ActivePage).getIDA,false)
     end;

 end;

 Procedure Tbook.Settings(temp:boolean);
 begin
 if (activepage<>nil) then
  Tdocument(activepage).FormSetting(temp);

 end;
 Procedure Tbook.AproxSettings;
 begin
 If (activepage<>nil) then Tdocument(activepage).AproxSettingsForm;

 end;
end.
