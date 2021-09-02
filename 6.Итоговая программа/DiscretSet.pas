unit DiscretSet;


interface

uses Chart, Grids, Line;

type

TDiscretSet = class(TObject)
protected
 id:integer;
 plottedField:Boolean;
 plottedFieldaprox:Boolean;
 ChartInstance:TChart;
 procedure SetPlotState (plotted:boolean);
 function GetLineID: integer;
// procedure SetPlotStateaprox (plotted:boolean);
public
 constructor Create(chart:TChart);
 destructor Destroy; override;
 procedure BuildLine; virtual; abstract;
 procedure DelLine;
 procedure Save(filePath:string); virtual; abstract;
 procedure Load(filePath:string); virtual; abstract;
 property Plotted: boolean read plottedField write SetPlotState;
 property Plottedaprox: boolean read plottedFieldaprox ;//write SetPlotStateaprox;
 //property plottedAprox:boolean read plotted
end;

implementation


constructor TDiscretSet.Create(chart:TChart);
begin
 inherited Create;
 ChartInstance := chart;
end;


destructor TDiscretSet.Destroy;
begin

end;

procedure TDiscretSet.SetPlotState (plotted:boolean);
begin
     if (plotted)
     then BuildLine
     else DelLine;
     self.plottedField := plotted;
end;

procedure TDiscretSet.DelLine;
begin
     if (Plotted)
     then begin
      self.plottedField := false;
      ChartInstance.DelLine(id);
      ChartInstance.Invalidate;
     end
end;

function TDiscretSet.GetLineID: integer;
begin
   if plotted then Result := id
              else Result := -1;

end;

end.

