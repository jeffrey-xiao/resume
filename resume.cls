\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}
\ProvidesClass{resume}[2016/02/10 Resume Class]

% Package declaration

\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{mdframed}
\RequirePackage{xstring}
\RequirePackage[nomessages]{fp}
\RequirePackage{ifthen}
\RequirePackage{enumitem}

% Color declaration

\definecolor{lightblue}{HTML}{87CEFA}
\definecolor{blue}{HTML}{0873B5}
\definecolor{darkblue}{HTML}{043757}
\definecolor{blackblue}{HTML}{00070C}
\definecolor{lightgreen}{HTML}{01FF70}
\definecolor{green}{HTML}{2ECC40}
\definecolor{pink}{HTML}{C26F67}
\definecolor{lightred}{HTML}{A93226}
\definecolor{darkred}{HTML}{641E16}
\definecolor{blackred}{HTML}{400C07}
\definecolor{orange}{HTML}{FF851B}
\definecolor{lightpurple}{HTML}{F012BE}
\definecolor{purple}{HTML}{B10DC9}
\definecolor{lightgray}{HTML}{777777}
\definecolor{gray}{HTML}{444444}
\definecolor{darkgray}{HTML}{333333}
\definecolor{white}{HTML}{eeeeee}

\colorlet{headerBackground}{white}
\colorlet{headerText}{gray}
\colorlet{headerEmph}{pink} % lightblue
\colorlet{titleText}{blackred} % blackblue
\colorlet{subTitleText}{darkred} % darkblue
\colorlet{bodyText}{darkgray}
\colorlet{tagText}{lightgray}
\colorlet{accent}{lightred}

\pagenumbering{gobble}
\noexpandarg
\newcounter{index}

% Header

\newcommand{\header}[4] {
  \begin{tikzpicture}[remember picture, overlay]
    \node [rectangle, anchor=north, minimum width=\paperwidth, minimum height=3.5cm] (box) at (current page.north) {};
      \node [anchor=center] (name) at (box) {
        \Huge\fontfamily{phv}\selectfont
        {\color{headerText} #1}{\color{headerEmph} #2}
      };
      \node [anchor=north, align=center] (contact) at (name.south) {
        \color{bodyText}\fontfamily{phv}\selectfont #3
      };
      \node [anchor=north, align=center] (links) at (contact.south) {
        \color{bodyText}\fontfamily{phv}\selectfont #4
      };
  \end{tikzpicture}
}

% Main

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{main} {
  \let\oldsection\section
  \renewcommand{\section}[1] {
    {
      \vspace{0.2cm}~
      \par
      \fontfamily{phv}\selectfont
      \color{titleText}\LARGE##1%
    }
    ~
  }

  \begin{textblock}{3.6}(1.5, 4.25)
  \begin{flushleft}
  \obeycr
  \vspace{-1.15cm}~
}{
  \restorecr
  \end{flushleft}
  \end{textblock}
  \let\section\oldsection
}

% Sidebar

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{sidebar} {
    \let\oldsection\section
    \renewcommand{\section}[1] {
    {
      \vspace{0.2cm}~
      \par
      \fontfamily{phv}\selectfont
      \color{titleText}\LARGE##1%
    }
    \vspace{0.25cm}~
  }

  \normalsize
  \fontfamily{phv}\selectfont
  \begin{textblock}{5.8}(14.5, 4.33)
  \begin{flushleft}
  \obeycr
  \vspace{-1cm}~
}{
  \restorecr
  \end{flushleft}
  \end{textblock}
  \let\section\oldsection
}

% List

\setlength{\tabcolsep}{0pt}

\newenvironment{entrylist} {
  \begin{tabular*} {\textwidth}{@{\extracolsep{\fill}}ll}
  \vspace{-0.2cm}~
} {
  \end{tabular*}
  \vspace{-0.7cm}~
}

\newcommand{\checknextarg}{\@ifnextchar\bgroup{\gobblenextarg}{\end{itemize}}}
\newcommand{\gobblenextarg}[1]{\item[--] #1\@ifnextchar\bgroup{\gobblenextarg}{\end{itemize}}}
\newcommand{\createlist}[1]{
  \begin{itemize}[leftmargin=0.45cm, noitemsep, topsep=0.1cm]
    \item[--]\color{bodyText}#1\checknextarg
}

\newcommand{\rightentry}[5] {
  \fontfamily{phv}\selectfont
  \vspace{0.2cm}\hspace{-0.05cm}\parbox[t]{12.0cm} {
    \fontfamily{phv}\selectfont
    \textbf{\color{subTitleText}#2} \hfill \color{tagText}\textbf{#3}\\
    \color{lightred}\emph{#4}\hfill \color{tagText}#1
    #5
  }
}

\newcommand{\leftentry}[2] {
  \fontfamily{phv}\selectfont
  \vspace{-0.2cm}
  \hspace{-0.05cm}\raggedright\parbox[t]{1.0cm}{\emph{#1}} & \parbox[t]{4.3cm}{#2}\\
}

\newcommand{\iconentry}[2] {
  \fontfamily{phv}\selectfont
  \parbox[t]{0.25cm}{\centering#1} \ #2
}

\def\replace#1#2#3{%
 \def\tmp##1#2{##1#3\tmp}%
   \tmp#1\stopreplace#2\stopreplace}
\def\stopreplace#1\stopreplace{}

\newcommand\separator{\color{accent}// \color{bodyText}}
\newcommand\iterate[1]{
  \replace{#1}{,}{\ \separator}
}

\newcommand\subheader[1]{
  \fontfamily{phv}\selectfont
  \vspace{0.2cm}
  \large\color{accent}#1\color{bodyText}\normalsize
}
