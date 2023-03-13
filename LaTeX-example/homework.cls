
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2023 Example LaTeX class for Homework]

\LoadClass[letterpaper,10pt,twoside]{article}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{bm}
\RequirePackage{mathtools}
\RequirePackage{mathrsfs}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{enumerate}
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage[left=1.in, right=1.in, top=1.5in, bottom=1.in]{geometry}
\RequirePackage{booktabs}
\RequirePackage{multicol}
\RequirePackage{siunitx}
\RequirePackage[style=authoryear, backend=biber, natbib=true]{biblatex}
\setlength\bibitemsep{1.5\itemsep}


%%====================================================================================
%% Variables to Change:
%%====================================================================================
\newcommand{\theclass}{MENG 451}
\newcommand{\theclasstitle}{Computational Dynamics}
\newcommand{\TheSemester}{Spring}
\newcommand{\TheYear}{2023}


\numberwithin{equation}{section}
\setcounter{secnumdepth}{3}


% ----- Header --------------------------------------------------------
\pagestyle{empty}
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{ \markright{#1} }
\fancyhf{}

\definecolor{gugray}{HTML}{666666}
\definecolor{gured}{HTML}{9a3b26}
\definecolor{gublue}{RGB}{0,63,114}

% \lhead{\color{gublue}\theclass, \TheSemester\ \TheYear}
%\chead{\color{gublue}HW \theHWset}
%{\color{gugray}\TheSemester\ \TheYear}
% \cfoot{\color{gugray}\thepage}
\fancyfoot[LE,RO]{\thepage}
\fancyhead[LE]{\textit{\color{gugray} \nouppercase{\theclass}} }
\fancyhead[RO]{\color{gugray} \textit{ \nouppercase{\rightmark}} }

% \setlength{\columnseprule}{0.5pt}

\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.5pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Macros
\newcommand*\diff{\mathop{}\!\mathrm{d}}
\providecommand\Vec{}
%\renewcommand{\Vec}[1]{ \vec{#1} }
\renewcommand{\Vec}[1]{ \bm{#1} }
% Unit vector
\newcommand{\uVec}[1]{ \hat{\bm{#1}} }
% 2nd order Tensor
\newcommand{\Ten}[1]{ \bm{#1} }
% 4th order Tensor
\newcommand{\TenF}[1]{ \bm{\mathfrak{#1}} }
% Colum Vector
\newcommand{\Col}[1]{ \bm{\mathsf{#1}} }
% Matrix
\newcommand{\Mat}[1]{ \bm{ \mathsf{ #1 }} }

\newcommand{\Laplace}{\mathscr{L}}
\newcommand{\InvLaplace}{\mathscr{L}^{-1}}
