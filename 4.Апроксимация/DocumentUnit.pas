unit DocumentUnit;

interface

 uses ComCtrls, Classes, StdCtrls, Controls, SysUtils, Dialogs, LastFiles,
      Menus, Grids, DataUnit, ChartUnit, Graphics, Approximation;

type

TDocument=class(TTabSheet)
 private
   StringGrid : TStringGrid;
   DataFileName : string;
   FullName : string;
   OpenDlg : TOpenDialog;
   SaveDlg : TSaveDialog;
   LFC : TLastFilesControler;
   Data : TData;
   Apprtn : TApproximation;
   _ActivePoint : integer;
   Chart : TChart;
   _Plotted : boolean;
   _ApprPlotted : boolean;
   procedure SetDocName(S : string);
   function  GetDocName : string;
   procedure SetActivePoint(z : integer);
   procedure OnSelectCellAction(Sender: TObject; ACol, ARow: Longint; var CanSelect: Boolean);
   procedure OnExitAction(Sender: TObject);
   procedure SetPlotStatus(z : boolean);
   procedure SetApprPlotStatus(z : boolean);
 public
   constructor Create(Owner: TComponent; LFC : TLastFilesControler; _Chart : TChart);
   procedure   SaveAs;
   procedure   Save;
   procedure   Open;
   Procedure   AddPoint;
   property    Name : string read GetDocName write SetDocName;
   property    ActivePoint : integer read _ActivePoint write SetActivePoint;
   procedure   OpenAs(FileName : string);
   destructor  Destroy;  override;
   procedure   GridToMas;
   Procedure   MasToGrid;
   Procedure   DataClear;
   procedure   LoadDataFromFile(FileName : String);
   property    Plotted : boolean read _Plotted write SetPlotStatus;
   property    ApprPlotted : boolean read _ApprPlotted write SetApprPlotStatus;
   procedure   BuildApproximation;
   //procedure DrawLine;
   //procedure DelLine;
end;

TBook = class(TPageControl)
  private
    CurrentDocNum : integer;
    LFC : TLastFilesControler;
    FullName : string;
    OpenDlg : TOpenDialog;
    _Plotted : boolean;
    _ApprPlotted : boolean;
    Chart : TChart;
    procedure AlreadyOpen(FullName : string);
    procedure SetPlotted(z : boolean);
    function GetPlotted : boolean;
    procedure SetApprPlotted(z : boolean);
    function GetApprPlotted : boolean;
  public
    constructor Create(AOwner: TWinControl; RootMenuItem : TMenuItem);
    destructor Destroy; override;
    procedure New;
    procedure Close;
    procedure Save;
    procedure SaveAs;
    procedure Open;
    procedure OpenAs(FullName : string);
    Procedure AddPoint;
    procedure DataClear;
    procedure GridToMas;
    property  Plotted : boolean read GetPlotted write SetPlotted;
    property ApprPlotted : boolean read GetApprPlotted write SetApprPlotted;
    procedure SetOutPort(Canvas : TCanvas; x1,y1,x2,y2 : integer);
    procedure Draw;
    procedure LoadData;
    procedure BuildApproximation;

end;

implementation
////////////////////////// TDocument /////////////////////////////////

constructor TDocument.Create(Owner: TComponent; LFC : TLastFilesControler; _Chart : TChart);
begin
  inherited Create(Owner);
  StringGrid := TStringGrid.Create(self);
  StringGrid.RowCount := 2;
  StringGrid.ColCount := 3;
  StringGrid.Parent := self;
  StringGrid.options := StringGrid.options + [goEditing, goRowMoving];
  StringGrid.Align := alLeft;
  StringGrid.OnSelectCell := OnSelectCellAction;
  StringGrid.OnExit := OnExitAction; //? ?????? ?????? ??????? ?? ?????????? ?!?!?!?
  FullName := '';
  SaveDlg := TSaveDialog.Create(self);
  self.LFC := LFC;
  Data := TData.Create(_Chart);
  _ActivePoint :=0;
  _Plotted := false;
  Apprtn := TApproximation.Create(_Chart, Data);
end;


procedure TDocument.OnSelectCellAction(Sender: TObject; ACol, ARow: Longint; var CanSelect: Boolean);
begin
  GridToMas;
  Data.Replot;
end;

procedure TDocument.OnExitAction(Sender: TObject);
begin
  {GridToMas;
  if Data.Plotted then Data.BuildLine;
  //showmessage('onexit')
  }
end;

procedure TDocument.SetDocName(s : string);
begin
  Caption := s;
end;

function TDocument.GetDocName : string;
begin
  Result := Caption;
end;


procedure TDocument.GridToMas;
  var i,j:integer;
begin
  Data.PairCount:=StringGrid.RowCount-1;
  for i:=0 to 1  do
    for j:=0 to Data.PairCount-1 do
      try
        Data[i,j] := StrToFloat(StringGrid.Cells[i+1,j+1]);
      except
        showmessage('???????? ???????? ? ??????');
        StringGrid.Cells[i+1,j+1] := '0';
      end;
end;


Procedure TDocument.MasToGrid;
  var i,j:integer;
begin
  StringGrid.RowCount := Data.PairCount + 1;
  for i:=0 to 1  do
    for j:=0 to Data.PairCount-1 do
        StringGrid.Cells[i+1,j+1] := FloatToStr(Data[i,j]);
end;


procedure TDocument.Save;
begin
    if FullName <> '' then
     begin
       GridToMas;
       Data.DataToFile(FullName);
     end
    else SaveAs;
end;

procedure TDocument.SaveAs;
var i : integer;
    S : string;
begin
  if SaveDlg.Execute then
    begin
      FullName := SaveDlg.FileName;
      GridToMas;
      Data.DataToFile(FullName);
      LFC.AddFile(FullName);
      i := length(FullName);
      while (i>0) and (FullName[i] <> '\') do
       begin
         S := FullName[i] + S;
         i := i-1;
       end;
     caption := s;
    end;
end;

procedure TDocument.Open;
begin
  try
    if OpenDlg.Execute then DataFileName := OpenDlg.FileName;
    Data.FileToData(DataFileName);
    MasToGrid;
    FullName  := DataFileName;
    Caption := FullName;
    LFC.AddFile(FullName);
   except
     ShowMessage('File not found');
     exit;
   end;
end;

procedure TDocument.OpenAs(FileName : string);
var i : integer;
    s : string;
begin
  try
     FullName:= FileName;
     Data.FileToData(FullName);
     MasToGrid;
     i := length(FullName);
     while (i>0) and (FullName[i] <> '\') do
       begin
         S := FullName[i] + S;
         i := i-1;
       end;
     caption := s;
     LFC.AddFile(FullName);
    except
     ShowMessage('File not found');
     exit;
    end;
end;

Procedure TDocument.AddPoint;
begin  
  Data.PairCount := Data.PairCount + 1;
  StringGrid.RowCount := Data.PairCount + 1;
  MasToGrid;
end;

Procedure TDocument.DataClear;
var i,j:integer;
begin
  Data.Clear;
  //StringGrid.Destroy;
  //StringGrid := TStringGrid.Create(self);
  for i := 1 to StringGrid.RowCount  do
    for j := 1 to 2 do
        StringGrid.cells[i,j] := '0';
  StringGrid.RowCount := 2;
  StringGrid.ColCount := 3;

  //StringGrid.Parent := self;
  //StringGrid.options := StringGrid.options + [goEditing];
  //StringGrid.Align := alClient;
end;

procedure TDocument.SetActivePoint(z : integer);
begin
  if (z < 1) then exit;
  _ActivePoint := z;
end;

destructor TDocument.Destroy;
begin
  //StringGrid.Free;
  if Data.Modified then
    if MessageDlg('Doc not saved! Save?', mtWarning, [mbYes, mbNo],
      0)= mrYes then  Save;
  Plotted := false;
  Apprtn.Destroy;
  Data.Destroy;
  inherited Destroy;
end;

{procedure TDocument.DrawLine;
begin
  try
    //_Plotted := true;
    Data.Plotted := true;
    Data.BuildLine;
  except
    showmessage('?????????? ????????? ??????')
  end;
end;}

procedure TDocument.LoadDataFromFile(FileName : string);
begin
  Data.FileToData(FileName);
  MasToGrid;
end;

procedure TDocument.SetPlotStatus(z : boolean);
begin
  try
      _Plotted := z;
      Data.Plotted := z;
//      Data.BuildLine;
  except
    showmessage('?????????? ????????? ??????')
  end;
end;

procedure TDocument.BuildApproximation;
begin
  Apprtn.Execute;
end;

procedure TDocument.SetApprPlotStatus(z: boolean);
begin
  try
        _ApprPlotted := z;
      Apprtn.Plotted := z;
  except
    showmessage('?????????? ????????? ??????')
  end;
end;

////////////////////////////// TBook /////////////////////////////
constructor TBook.Create(AOwner: TWinControl; RootMenuItem : TMenuItem);
begin
  inherited Create(AOwner);
  Parent := AOwner;
  CurrentDocNum := 0;
    OpenDlg := TOpenDialog.Create(self);
  LFC := TLastFilesControler.Create(RootMenuItem, OpenAs);
  Chart := TChart.Create;
  _Plotted := false;
end;

procedure TBook.New;
var Doc : TDocument;
begin
  inc(CurrentDocNum);
  Doc := TDocument.Create(self, LFC, Chart);
  Doc.PageControl := self;
  Doc.Name := 'Document_' + IntToStr(CurrentDocNum);
  ActivePage := Doc;
  if Assigned(OnChange) then OnChange(nil);
end;

procedure TBook.Close;
var Doc : TDocument;
begin
  Doc := ActivePage as TDocument;
  Doc.Destroy;     
end;

Procedure TBook.AddPoint;
  var Doc : TDocument;
begin
  Doc := ActivePage as TDocument;
  Doc.AddPoint;
end;

procedure TBook.Save;
  var Doc : TDocument;
begin
  Doc := ActivePage as TDocument;
  Doc.Save;
end;

procedure TBook.SaveAs;
  var Doc : TDocument;
begin
  Doc := ActivePage as TDocument;
  Doc.SaveAs;
end;

procedure TBook.DataClear;
  var Doc : TDocument;
begin
  Doc := ActivePage as TDocument;
  Doc.DataClear;
end;

procedure TBook.GridToMas;
  var Doc : TDocument;
begin
  Doc := ActivePage as TDocument;
  Doc.GridToMas;
end;

procedure TBook.Open;
begin
  New;
      if OpenDlg.Execute then
       begin
        FullName := OpenDlg.FileName;
        AlreadyOpen(FullName);
       end;
end;

procedure TBook.OpenAs(FullName : string);
begin
    New;
    //(ActivePage as TDocument).OpenAs(FullName);
    AlreadyOpen(FullName);
end;

procedure TBook.AlreadyOpen(FullName : string);
var i:integer; S: string;
    k:boolean;
begin
   k := true;
   s := FullName;

   For i := 0 to PageCount-1 do
    if TDocument(Pages[i]).Name=S then
      begin
        k:=false;
        //ActivePage := Doc;
      end;
   if k=true then (ActivePage as TDocument).OpenAs(FullName)
             else Close;
end;

destructor TBook.Destroy;
var i, j:integer;
    doc:TDocument;
begin
  j :=PageCount ;
  For i := 0 to j-1 do
      TDocument(Pages[0]).Destroy;
  LFC.Destroy;
  inherited Destroy;
end;

procedure TBook.SetPlotted(z : boolean);
begin       {~!!!!!!!!!!!!!!!!!!!!!!!!!!~}
  _Plotted := (ActivePage as TDocument).Plotted;
  (ActivePage as TDocument).Plotted := z;
end;

function TBook.GetPlotted : boolean;
begin
  result := (ActivePage as TDocument).Plotted;
end;

procedure TBook.SetOutPort(Canvas : TCanvas; x1,y1,x2,y2 : integer);
begin
  Chart.SetOutPort(Canvas, x1,y1,x2,y2);
end;

procedure TBook.Draw;
begin
  Chart.Draw;
end;

procedure TBook.LoadData;
begin
  if OpenDlg.Execute then (ActivePage as TDocument).LoadDataFromFile(OpenDlg.FileName);
end;

procedure TBook.BuildApproximation;
begin
  (ActivePage as TDocument).BuildApproximation;
end;

function TBook.GetApprPlotted: boolean;
begin
   result := (ActivePage as TDocument).ApprPlotted;
end;

procedure TBook.SetApprPlotted(z: boolean);
begin
    _ApprPlotted := (ActivePage as TDocument).ApprPlotted;
  (ActivePage as TDocument).ApprPlotted := z;

end;




end.
