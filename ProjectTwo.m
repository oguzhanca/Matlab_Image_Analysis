function varargout = ProjectTwo(varargin)
% PROJECTTWO MATLAB code for ProjectTwo.fig
%      PROJECTTWO, by itself, creates a new PROJECTTWO or raises the existing
%      singleton*.
%
%      H = PROJECTTWO returns the handle to a new PROJECTTWO or the handle to
%      the existing singleton*.
%
%      PROJECTTWO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTTWO.M with the given input arguments.
%
%      PROJECTTWO('Property','Value',...) creates a new PROJECTTWO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectTwo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectTwo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectTwo

% Last Modified by GUIDE v2.5 10-Dec-2014 18:03:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectTwo_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectTwo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ProjectTwo is made visible.
function ProjectTwo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectTwo (see VARARGIN)

% Choose default command line output for ProjectTwo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectTwo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectTwo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global row;
global column;
global Image;
global clicked;
clicked = true;

[filename pathname]= uigetfile('*.bmp', 'Select Image File');

Image = imread('lena.bmp');
[row , column] = size(Image);
axes(handles.axes1);
imshow(Image);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global row;
global column;
global Image;
global clicked;

pos = get(hObject, 'currentpoint'); 
x = round(pos(1,1)); y = round(pos(1,2));

if (0<x && x<512) && (0<y && y<512) && ~(isempty(Image)) && clicked == true
    
set(handles.x, 'string', ['x loc:' num2str(x)]);
set(handles.y, 'string', ['y loc:' num2str(y)]);
set(handles.greyvalue, 'string', ['Grey value:' num2str(Image(x,y))]);
plot(handles.axes3, 1:column , Image(x, :))
plot(handles.axes4, Image(:, y), 1:row)

else
    if clicked == true
    set(handles.x, 'string', ['x loc:' num2str(0)]);
    set(handles.y, 'string', ['y loc:' num2str(0)]);
    set(handles.greyvalue, 'string', ['Grey value:' num2str(0)]);
    end
end


% --- Executes on button press in saveX.
function saveX_Callback(hObject, eventdata, handles)
% hObject    handle to saveX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName, PathName] = uiputfile('*.png', 'Save As');
if PathName == 0
    return; 
end
Name = fullfile(PathName, FileName);
Img = frame2im(getframe(handles.axes3));
imwrite(Img, Name, 'png');

%--- Executes on button press in saveY.
function saveY_Callback(hObject, eventdata, handles)
% hObject    handle to saveY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uiputfile('*.png', 'Save As');
if PathName == 0
    return; 
end
Name = fullfile(PathName, FileName);
Img = frame2im(getframe(handles.axes4));
imwrite(Img, Name, 'png');


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
global clicked;

if clicked == false
    clicked = true;
else
    clicked = false;
end

% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
