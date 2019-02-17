function varargout = VBC(varargin)
% VBC MATLAB code for VBC.fig
% VBC means V Belt Calculation
%
%      VBC, by itself, creates a new VBC or raises the existing
%      singleton*.
%
%      H = VBC returns the handle to a new VBC or the handle to
%      the existing singleton*.
%
%      VBC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VBC.M with the given input arguments.
%
%      VBC('Property','Value',...) creates a new VBC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VBC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VBC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VBC

% Last Modified by GUIDE v2.5 08-Dec-2018 19:15:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VBC_OpeningFcn, ...
                   'gui_OutputFcn',  @VBC_OutputFcn, ...
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


% --- Executes just before VBC is made visible.
function VBC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VBC (see VARARGIN)

global Pd yilei erlei chuandongbi zhuansu TYPE Dd1array Dd1 MINMAX P0array... 
Narray Vmax Ldarray Dd1pos Kaarray Klarray Dd2array DSPcellarray CELLDSP TABLEPOS HEADMES;

Vmax = 25;
%Basic rated power of common V-belt
P0array = [
0.00 0.04,0.06,0.09,0.10,0.12,0.14,0.16,0.17,0.20,0.22,0.26,0.28,0.30,0.32,0.33,0.34,0.33,0.31;
0.00 0.05,0.08,0.13,0.15,0.18,0.22,0.25,0.27,0.32,0.37,0.41,0.45,0.47,0.49,0.50,0.50,0.49,0.48;
0.00 0.06,0.09,0.17,0.20,0.23,0.27,0.30,0.33,0.39,0.46,0.50,0.54,0.58,0.61,0.62,0.62,0.61,0.58;
0.00 0.10,0.14,0.20,0.22,0.26,0.30,0.35,0.39,0.44,0.50,0.56,0.61,0.64,0.67,0.67,0.66,0.64,0.00;
0.00 0.15,0.26,0.40,0.45,0.51,0.60,0.68,0.73,0.84,0.92,1.00,1.04,1.08,1.09,1.07,1.02,0.96,0.80;
0.00 0.22,0.39,0.61,0.68,0.77,0.93,1.07,1.05,1.34,1.50,1.64,1.73,1.83,1.87,1.88,1.82,0.00,0.00;
0.00 0.26,0.47,0.74,0.83,0.95,1.14,1.32,1.42,1.66,1.87,2.05,2.19,2.28,2.34,2.33,0.00,0.00,0.00;
0.00 0.37,0.67,1.07,1.19 1.37 1.66 1.92 2.07 2.44 2.74 2.98 3.16 3.26 0.00 0.00 0.00 0.00 0.00;
0.00 0.48 0.84 1.30 1.44 1.64 1.93 2.19 2.33 2.64 2.85 2.96 2.94 2.80 0.00 0.00 0.00 0.00 0.00;
0.00 0.59 1.05 1.64 1.82 2.08 2.47 2.82 3.00 3.42 3.70 3.85 3.83 0.00 0.00 0.00 0.00 0.00 0.00;
0.00 0.74 1.32 2.09 2.32 2.66 3.17 3.62 3.86 4.40 4.75 4.89 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
0.00 0.88 1.59 2.53 2.81 3.22 3.85 4.39 4.68 5.30 5.67 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
0.00 1.39 2.41 3.69 4.07 4.58 5.29 5.84 6.07 6.34 6.02 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
0.00 2.03 3.62 5.64 6.23 7.04 8.21 9.04 9.38 9.62 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
0.00 2.84 5.14 8.09 8.92 10.05 11.53 12.46 12.72  0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
0.00 3.91 7.06 11.02 12.10 13.48 15.04 0.0 0.000  0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
3.01 5.31 9.24 13.70 14.83 16.15 17.25 16.77 15.63 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
3.66 6.52 11.45 17.07 18.46 20.06 21.20 0.00 0.000 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
4.37 7.90 13.85 20.63 22.25 24.01 24.84 0.00 0.000 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
5.08 9.21 16.20 23.99 25.76 27.50 0.000 0.00 0.000 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
6.21 10.86 18.55 26.21 27.57 28.32 0.00 0.00 0.000 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
7.32 13.09 22.49 31.59 33.03 33.40 0.00 0.00 0.000 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
8.75 15.65 26.95 37.26 38.62 0.000 0.00 0.00 0.000 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
10.31 18.52 31.83 42.87 43.52 0.00 0.00 0.00 0.000 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00;
];

%range of n1 for every specific belt 
MINMAX = [950,6000;800,6000;700,6000;700,6000;200,600;200,6000;200,6000;
          200,5500;200,6000;200,5000;200,4500;200,3600;200,3600;200,3200;
          200,2800;200,2400;200,2400;200,2000;200,1600;200,1200;
          100,1600;100,1200;100,1200;100,950;100,950;100,950;100,800;100,800;];

%basic n1 values
Narray = [100,200,400,700,800,950,1200,1450,1600,2000,2400,2800,3200,3600,4000,4500,5000,5500,6000];
 
%Datum length
Ldarray = [200,224,250,280,315,355,400,450,500,560,630,710,800,900,1000,1120,1250,1400,1600,1800,2000,2240,2500,2800,3150,3550,4000,4500,5000];

%Optimum selection of pulley diameter series
Dd2array = [20,28,31.5,35.5,40,45,50,56,63,71,80,90,100,112,125,140,150,160,180,200,224,250,280,315,355,400,425,450,500,560,600,630,710,800];
 
%two classes for Ka
yilei = [1:0.1:1.2; 1.1:0.1:1.3; 1.2:0.1:1.4; 1.3:0.1:1.5];%I-class
erlei = [1.1:0.1:1.3; 1.2:0.1:1.4; 1.4:0.1:1.6; 1.5,1.6,1.8];%II-class
 
%atually this Ka is K\alpha
Kaarray = [220,210,200,190,180,170,160,150,140,130,120,110,100,90;
           1.20,1.15,1.10,1.05,1.00,0.98,0.95,0.92,0.89,0.86,0.82,0.78,0.73,0.68];
     
%
Klarray = [
200  zeros(1,6);
224  zeros(1,6);
250  zeros(1,6);
280 zeros(1,6);
315  zeros(1,6);
355  zeros(1,6);
400  0.87 zeros(1,5);
450  0.89 zeros(1,5);
500 0.91 zeros(1,5);
560 0.94 zeros(1,5);
630 0.96 0.81 zeros(1,4);
710 0.99 0.83 zeros(1,4);
800 1.00 0.85 zeros(1,4);
900 1.03 0.87 0.82 zeros(1,3);
1000 1.06 0.89 0.84 zeros(1,3);
1120 1.08 0.91 0.86 zeros(1,3);
1250 1.10 0.93 0.88 zeros(1,3);
1400 1.14 0.96 0.90 zeros(1,3);
1600 1.16 0.99 0.92 0.83 0 0;
1800 1.18 1.01 0.95 0.86 0 0;
2000 0 1.03 0.98 0.88 0 0;
2240 0 1.06 1.00 0.91 0 0;
2500 0 1.09 1.03 1.93 0 0;
2800 0 1.11 1.05 0.95 0.83 0;
3150 0 1.13 1.07 0.97 0.86 0;
3550 0 1.17 1.09 0.99 0.89 0;
4000 0 1.19 1.13 1.02 0.91 0;
4500 0 0 1.15 1.04 0.93 0.90;
5000 0 0 1.18 1.07 0.96 0.92];
 
%Minimum datum diameter of V-belt pulley
Dd1array = [50 63 71 80 75 90 100 125 140 160 180 200 250 315 400 355 400 450 500 560 630 710];

TABLEPOS = 1;

%clear table results
changetabledsp(handles.uitable1,'deleteall',TABLEPOS,TYPE);

%clear a0 value
set(handles.edit9,'string','');

% Choose default command line output for VBC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VBC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VBC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Pd yilei erlei chuandongbi zhuansu TYPE Dd2array Dd1 Dd2 TABLEPOS HEADMES;
for i=1:1
    p = get(handles.edit1,'string');   %power
    n1 = get(handles.edit3,'string');  %spin speed
    cd = get(handles.edit2,'string');  %ratio of movement
    gonglv = eval(p);%the next three line maybe of no use
    zhuansu = eval(n1);
    chuandongbi = eval(cd);

    GZJ=get(handles.popupmenu2,'value'); %working machine
    SJ=get(handles.popupmenu1,'value');  %working time hour per day
    YDJ=get(handles.popupmenu3,'value'); %type of prime mover

    if(YDJ == 1 || YDJ == 3 || YDJ == 4 || YDJ == 6)
        leibie = 1; %I-class
    else
        leibie = 2; %II-class
    end

    if(leibie == 1)
            Ka = yilei(GZJ,SJ);
    else
            Ka = erlei(GZJ,SJ);
    end

    check1 = get(handles.checkbox1,'value');
    check2 = get(handles.checkbox2,'value');
    check3 = get(handles.checkbox3,'value');
    
    gongzuochanghe = check1 | check2 | check3;
    
    if(gongzuochanghe == 1)%existing 1 is 1
        Ka = Ka*1.2;
    end

    Pd=Ka*gonglv;
    xianshi=sprintf('%0.2f %s',Pd);
    set(handles.edit6,'string',xianshi);

end


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h0 = figure('toolbar','auto','name','ddmin','NumberTitle','off','menubar','none');
I = imread('select.png');
imshow(I);
%guidata(hObject, eventdata);

% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
global TYPE Dd1pos Dd1array Dd1 Dd2 Dd2array chuandongbi Vmax;

%obtain belt type, Z-1, A-2, B-3, C-4, D-5, E-6
TYPE = get(handles.popupmenu4,'value');
switch(TYPE)
        case 1
            set(handles.popup,'string','50|63|71|80|75|90');
        case 2
            set(handles.popup,'string','75|90|100|125|140|160');
        case 3
            set(handles.popup,'string','125|140|160|180|200|250');
        case 4
            set(handles.popup,'string','200|250|315|400|450|500');
        case 5
            set(handles.popup,'string','355|400|450|500|560|630');
            Vmax = 30;
        case 6
            set(handles.popup,'string','500|560|630|710');
            Vmax = 30;
end
Dd1pos = get(handles.popup,'value'); %确定popup中Dd1选择的位置
Dd1 = Dd1array((TYPE - 1) * 4 + Dd1pos);
Dd22 = chuandongbi*Dd1;
Dd2 = nearest(Dd22,Dd2array);
a01 = 0.7*(Dd1+Dd2);
a02 = 2*(Dd1+Dd2);
pa1 = num2str(a01);
pa2 = num2str(a02);
set(handles.edit7,'string',pa1);
set(handles.edit8,'string',pa2);

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup.
function popup_Callback(hObject, eventdata, handles)
% hObject    handle to popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup
global Dd1 TYPE Dd1array Dd1pos Dd2 Dd2array chuandongbi;
Dd1pos = get(handles.popup,'value'); %确定popup中Dd1选择的位置
Dd1 = Dd1array((TYPE - 1) * 4 + Dd1pos);
Dd22 = chuandongbi * Dd1;
Dd2 = nearest(Dd22, Dd2array);
a01 = 0.7*(Dd1 + Dd2);
a02 = 2*(Dd1 + Dd2);
pa1 = num2str(a01);
pa2 = num2str(a02);
set(handles.edit7, 'string', pa1);
set(handles.edit8, 'string', pa2);

% --- Executes during object creation, after setting all properties.
function popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Pd yilei erlei chuandongbi zhuansu TYPE Dd1 Dd2 MINMAX P0array Narray Vmax Ldarray Dd1pos Kaarray Dd2array Klarray TABLEPOS data datafront;
clc;       
for i = 1:1 
Dd22 = chuandongbi*Dd1;
Dd2 = nearest(Dd22,Dd2array);
V = pi*Dd1*zhuansu/(60*1000);                            %velocity                                  
a0 = str2double(get(handles.edit9,'string'));            %central distance
Ldpie = 2*a0 + 1.57*(Dd1 + Dd2) + (Dd2 - Dd1)^2/(4*a0);  %initial Datum length
Ld = nearest(Ldpie,Ldarray);                             %final Datum length
a = round(a0 + (Ld-Ldpie)/2);                            %final central distance
 
alf1 = 180 - (Dd2 - Dd1)/a*57.3; 
P0 = P0func(zhuansu,MINMAX,P0array,Narray,TYPE,Dd1pos);            
Ka = baojiao(alf1,Kaarray);
Kl = daichangxiuzheng(Ld,TYPE,Klarray);                                  
Kb = wanquyingxiang(TYPE);
 
Ki = chuandongbixishu(chuandongbi);
dietaP0 = Kb*zhuansu*(1 - 1/Ki);
Zfront = Pd/(P0 + dietaP0)/Ka/Kl;                                            
Z = ceil(Zfront);
 
m = mass(TYPE);
if(Z<1)
    Z=1;
end
    F0=500*Pd/(V*Z)*((2.5-Ka)/Ka)+m*V^2;
    Fq=2*F0*Z*sin(alf1/360*pi);
%update result table
data={Z,Ld,a,alf1,V,Dd2,F0,Fq};
changetabledsp(handles.uitable1,'write',TABLEPOS,TYPE,data);
TABLEPOS = TABLEPOS + 1;
end 

% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ka = baojiao(alf1,Kaarray)
%calculate Small round bag angle
[a,b]=lookforpos(alf1,Kaarray(1,:));
Ka=interp1([Kaarray(1,a),Kaarray(1,b)],[Kaarray(2,a),Kaarray(2,b)],alf1);

function changetabledsp(tableh,s,pos,TYPE,data)
%update table
global DSPcellarray HEADMES;

switch(TYPE)
    case 1
        xingbie = 'Z';
    case 2
        xingbie = 'A';
    case 3
        xingbie = 'B';
    case 4
        xingbie = 'C';
    case 5
        xingbie = 'D';
    case 6
        xingbie = 'E';
end

switch(s)
    case 'deleteall'
        DSPcellarray = initcell();
    case 'write'
        DSPcellarray = write(DSPcellarray,pos,xingbie,data);
end

DSP={
DSPcellarray{1}{1:end};
DSPcellarray{2}{1:end};
DSPcellarray{3}{1:end};
DSPcellarray{4}{1:end};
DSPcellarray{5}{1:end};
DSPcellarray{6}{1:end};
DSPcellarray{7}{1:end};
DSPcellarray{8}{1:end};
DSPcellarray{9}{1:end};
DSPcellarray{10}{1:end};
     };
set(tableh,'data',DSP);

DSQ={
1 DSPcellarray{1}{1:end};
2 DSPcellarray{2}{1:end};
3 DSPcellarray{3}{1:end};
4 DSPcellarray{4}{1:end};
5 DSPcellarray{5}{1:end};
6 DSPcellarray{6}{1:end};
7 DSPcellarray{7}{1:end};
8 DSPcellarray{8}{1:end};
9 DSPcellarray{9}{1:end}; 
10 DSPcellarray{10}{1:end}; 
};

function DSP = write(DSParray,pos,xingbie,data)
%write data into the table
DSParray{pos} = {xingbie data{1:end}};
DSP=DSParray;

function DSPce = initcell()
%Initialize the cell array used to display the table
for i = 1:10
    dsp{i} = {'',[],[],[],[],[],[],[],[]};
end
DSPce = dsp;

function Ki = chuandongbixishu(chuandongbi)
%find Ki
i = chuandongbi;
if(i >= 1 && i < 1.01)
    Ki = 1;
    elseif(i >= 1.01 && i < 1.04)
        Ki = 1.0136;
    elseif(i >= 1.04 && i < 1.08)
        Ki = 1.0276;
    elseif(i >= 1.08 && i < 1.12)
        Ki = 1.0419;
    elseif(i >= 1.12 && i < 1.18)
        Ki = 1.0567;
    elseif(i >= 1.18 && i < 1.24)
        Ki = 1.0719;
    elseif(i >=1.24 && i < 1.34)
        Ki = 1.0875;
    elseif(i >= 1.34 && i < 1.51)
        Ki = 1.1036;
    elseif(i >= 1.51 && i < 1.99)
        Ki = 1.1202;
    elseif(i >= 1.99)
        Ki = 1.1373;
end

function Kl = daichangxiuzheng(Ld,TYPE,Klarray)
%fix the length of belt
p = find(Klarray(:,1) == Ld);
Kl=Klarray(p,(TYPE+1));

function [a,b]=lookforpos(k,shuzu)
%Used to find which two numbers of an array are sandwiched between
%If not found, a and b are -1
a1 = find(shuzu >= k);
a2 = find(shuzu <= k);
if(isempty(a1) || isempty(a2))
    a = -1;
    b = -1;
else
    a = a1(1);%Note: Just locate, not the number of locations
    b = a2(end);
    if(abs(a - b) > 1)
        a = a1(end);
        b = a2(1);
    end
end

function m = mass(TYPE)
%Calculate band quality
p = [0.06,0.1,0.17,0.3,0.6,0.9];
m = p(TYPE);

function back = nearest(a,p)
%Find the closest value to a in the array p, and assign it to back
pp = p - a.*ones(size(p));
k = find(abs(pp) == min(abs(pp)));
%Note that when the difference between the two values is the same here, 
%the number at the top of P is chosen according to the order of arrangement.
back=p(k(1));

function P0=P0func(zhuansu,minmax,P0array,Narray,TYPE,Dd1pos)
%Used to find rated power P0 in the table, if not found, return to - 1;
%The above data correspond to the global variable names in the GUI
weizhix=(TYPE-1)*4+Dd1pos;
if(zhuansu > minmax(weizhix,2) || zhuansu < minmax(weizhix,1))
    P0 = -1;
else
    [a,b] = lookforpos(zhuansu,Narray);
    P0 = interp1([Narray(a),Narray(b)],[P0array(weizhix,a),P0array(weizhix,b)],zhuansu);
end

function plotline(a,b,s,area)
%Draw a straight line according to two points [a, b].
%Area is the range of independent variables.
%If there is no range of input variables, 
%the default values a and B are endpoint coordinates, respectively.
if(a(1) > b(1))
   c = a;
   a = b;
   b = c;
end
if(nargin == 2)
    s = '-';
    area = [a(1),b(1)];
end
if(nargin == 3)
    area = [a(1),b(1)];  
end
p = polyfit([a(1),b(1)],[a(2),b(2)],1);
x = linspace(area(1),area(2),ceil((b(1)-a(1))*500));
x1 = log(x);
y = polyval(p,x);
plot(x1,y,s);

function Kb = wanquyingxiang(TYPE)
%find Kb
table = [0.2915 0.7725 1.9875 5.625 19.95 37.35]/1000;
Kb = table(TYPE);

%-------------------------------------------------------------------
%------------------------------end----------------------------------
%-------------------------------------------------------------------
