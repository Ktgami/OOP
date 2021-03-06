unit Document;

interface

uses StdCtrls, ComCtrls, Controls, Dialogs, LastFileController, Book, MainForm, SysUtils,
    Grids, Chart, Data, Approximation,FormSettings,Graphics,unit3;

type
 TCLickEnter = procedure (Sender: Tobject) of object;
TDocument=class(TTabSheet)
  private
    Grid : TStringGrid;
    id_LV:integer;
    name_LVap:string;
    FullName : string;
    OpenDlg : TOpenDialog;
    SaveDlg : TSaveDialog;
    FileLast:TLastFileController;
    Chart: TChart;
    Data: TData;
    plotted_LV_Doc:boolean;
    plotted_LV_Doc_Ap:boolean;
    Approximation : TApproximation;
   // procedure BooleanAprox;
    procedure SetDocName(S : string);
 //   function setID(_Id:integer):integer;
    function GetDocName : string;
    procedure CorrectCaption;
    procedure UpdateGrid;
  //  procedure UpdateData;
    procedure SetPlotState (plotted:boolean);
    function GetPlotState:boolean;
//    procedure SetPlotStateAprox (plottedAprox:boolean);
 //   function GetPlotStateAprox:boolean;
    public
    constructor Create(AOwner: TWinControl; FileLast:TLastFileController; Chart: TChart;CLick_LV:TClickenter);
    function BooleanAproxget:Boolean;
    procedure BooleanAproxSet(plotted_LV2:Boolean);
    destructor Destroy; override;
   // property id:integer read ID_LV write setID;
    property Name : string read GetDocName write SetDocName;
    procedure Open;
    procedure OpenAs(FileName : string);
    function Save:string;
    function SaveAs:string;
     function getIDA:integer;
    procedure OpenFrom(path:string);
    procedure UpdateData;
    procedure FormSetting(temp:boolean);
        procedure AddPoint;
        function getID:integer;
    procedure DelPoint;
    procedure Clear;
    procedure TypeAprox(name_LV1:string);
     procedure OnSelectCellActionAP;
    procedure Mnkpower(P_LV:integer);
    procedure BuildLine;
    property Plotted: boolean read GetPlotState write SetPlotState;
    property plottedAprox:Boolean read BooleanAproxget write BooleanAproxSet;
   // property PlottedAprox: boolean read GetPlotStateAprox write SetPlotStateAprox;
    procedure OnSelectCellAction;
    procedure AproxSettingsForm;
    end;

implementation

 constructor TDocument.Create(AOwner: TWinControl; FileLast: TLastFileController; Chart: TChart;Click_LV:TClickenter);
   var i:integer;
   begin
     inherited Create(AOwner);
     self.Chart := Chart;
     Data := TData.Create(self.Chart);
     Approximation := TApproximation.Create(Data, Chart);
     Grid := TStringGrid.Create(self);
     Grid.ColCount := 3;
     Grid.RowCount := 2;
     Grid.Options := Grid.Options + [goEditing];
     Grid.Cells[0,0] := 'N';
     Grid.Cells[1,0] := 'X';
     Grid.Cells[2,0] := 'Y';
     Grid.Cells[0,1] := '1';
     Grid.Parent := self;
     Grid.Align := alClient;
     OpenDlg := TOpenDialog.Create(self);
     SaveDlg := TSaveDialog.Create(self);
     FullName := '';
     self.FileLast := FileLast;
     grid.OnDblClick :=Click_LV;
     plotted_LV_Doc_Ap:=false;
     plotted_LV_Doc:=false;

    end;


 destructor TDocument.Destroy;
   begin
     //if Memo.Modified then
      if MessageDlg('File not saved. Save now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then Save;
      Data.Destroy;
      Approximation.Destroy;
     inherited Destroy;
   end;

 procedure TDocument.SetDocName(S : string);
   begin
     Caption := S;
   end;

 function TDocument.GetDocName : string;
   begin
     GetDocName := Caption;
   end;

 function TDocument.Save: string ;
  begin
    if FullName <> '' then
     begin
       UpdateData;
       data.Save(FullName);
      end
    else SaveAs;
  end;

 procedure TDocument.CorrectCaption;
  var S : string;
      i : integer;
   begin
     S := '';
     i := length(FullName);
     while (i>0) and (FullName[i] <> '\') do
       begin
         S := FullName[i] + S;
         dec(i);
       end;
     Caption := S;
   end;

 function TDocument.SaveAs: string ;
var old:string;
   begin
     if SaveDlg.Execute then
       begin
         old:=FullName;
         FullName := SaveDlg.FileName;
         Caption := FullName;
         CorrectCaption;
         UpdateData;
         data.Save(FullName);

         FileLast.AddItem(FullName);
         Result:=FullName;
       end;
   end;

 procedure TDocument.Open;
 begin
     if OpenDlg.Execute then OpenAs(OpenDlg.FileName);
 end;

 procedure TDocument.OpenAs(FileName : string);
 begin
         FullName := FileName;
         CorrectCaption;
         if FileExists(FullName) then
         begin
          data.Load(FullName);
          UpdateGrid;
          FileLast.AddItem(FullName);
         end;
 end;

   procedure TDocument.OpenFrom(path:string );
   begin
     if path <> '' then
       begin
         FullName := path;
         CorrectCaption;
         if FileExists(FullName) then begin
          data.Load(FullName);
          UpdateGrid;
          FileLast.AddItem(FullName);
          end;
       end
     else Free;
   end;

   procedure TDocument.UpdateGrid;
   var i:integer;
   begin
     Grid.RowCount := data.Count+1;
     for i:=0 to data.Count-1 do
      begin
        grid.Cells[0,i+1] := IntToStr(i+1);
        grid.Cells[1,i+1] := FloatToStr(data.pointsList[i].X);
        grid.Cells[2,i+1] := FloatToStr(data.pointsList[i].Y);
      end;
     if (Grid.RowCount < 2)
     then
     begin
      Grid.RowCount := 2;
      Grid.FixedRows := 1;
      grid.Cells[0,1] := '1';
      grid.Cells[1,1] := '';
      grid.Cells[2,1] := '';
     end;
   end;
   procedure TDocument.UpdateData;
   var i:integer;
      x,y:extended;
   begin
     Data.Clear;
      for i:= 1 to (Grid.RowCount-1) do
       if (Grid.Cells[1,i] <> '') and (Grid.Cells[2,i] <> '')
       then if TryStrToFloat(Grid.Cells[1,i], x) and TryStrToFloat(Grid.Cells[2,i], y)
            then data.AddPoint(x,y);

   end;
   procedure TDocument.AddPoint;
   begin
        Grid.RowCount := Grid.RowCount + 1;
        Grid.Cells[0, Grid.RowCount-1] := intToStr(Grid.RowCount-1);
   end;
   procedure TDocument.DelPoint;
   begin
        if (Grid.RowCount > 2)
        Then Grid.RowCount := Grid.RowCount - 1;
        updatedata;
   end;
   procedure TDocument.Clear;
   begin
        Data.Clear;
        UpdateGrid;
        Data.Plotted := false;
      //  Approximation.Plotted := false;
   end;

   procedure TDocument.SetPlotState(plotted:boolean);
   begin
        if (plotted)
        then UpdateData;
        Data.Plotted :=  plotted;
        plotted_LV_Doc:=plotted;
       // Approximation.Plotted := plotted;   //??? ???? ???? ??????? ? ?????????????
        //Approximation.Plotted := plotted;
   end;



   procedure TDocument.BuildLine;
   begin
     SetPlotState(true);
   end;

   function TDocument.GetPlotState:boolean;
   begin
        GetPlotState := Data.Plotted;
   end;

   procedure TDocument.OnSelectCellAction;
   begin
        UpdateData;
        if Data.Plotted
        then begin
                  Data.DelLine;
                  Data.BuildLine;
             end
   end;
      procedure TDocument.OnSelectCellActionAP;
   begin
        UpdateData;
        if Approximation.Plotted
        then begin
                  Approximation.DelLine;
                  Approximation.execute(form3.getaproxType);

                  Approximation.buildline;
             end
   end;

      function Tdocument.BooleanAproxGet:boolean;
   begin
     result:= Approximation.Plotted;

   end;
   procedure Tdocument.BooleanAproxSet(plotted_LV2:boolean) ;

   begin
//        if (plotted)
//        then UpdateData;
       if plotted_LV2 then
       begin
         UpdateData ;

        Approximation.execute(name_LVap);
        end;
      plotted_LV_Doc_Ap:=plotted_LV2;
       Approximation.Plotted := plotted_LV2;

   end;
   procedure Tdocument.TypeAprox(name_LV1:string);
   begin
      name_LVAp:=name_LV1;
   end;
    procedure Tdocument.mnkpower(p_Lv:integer);
   begin
      Data.MNKPower:=p_lv;
   end;

   Procedure TDocument.FormSetting(temp:boolean);
   var  String_LV:string;
   begin

     if  not temp then chart.Settings(data.LineID)
                  else chart.settings(Approximation.lineID);

   end;

    function Tdocument.getID:integer;
    begin
    getID:=data.LineID;
   // getID:=Approximation.id;
    end;

        function Tdocument.getIDA:integer;
    begin

   result:=Approximation.LineID;
    end;

    procedure Tdocument.AproxSettingsForm;
     var string_LV:string;
      begin

        form3.ShowModal;
         string_LV:= form3.getaproxType;
       self.TypeAprox(string_LV);
       self.Mnkpower(form3.GetMNKPOwer);
     //  Approximation.BuildLine;

       if plotted_LV_Doc_Ap then
       begin
          self.OnSelectCellActionAP;
     // Chart.SetSettings(self.getID);

     end;


      end;

end.
