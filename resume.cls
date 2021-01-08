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
\RequirePackage{fontspec}

% Color declaration

\definecolor{pink}{HTML}{C26F67}
\definecolor{lightred}{HTML}{A93226}
\definecolor{darkred}{HTML}{641E16}
\definecolor{blackred}{HTML}{400C07}
\definecolor{lightgray}{HTML}{5B7085}
\definecolor{gray}{HTML}{33404B}
\definecolor{darkgray}{HTML}{1B2228}
\definecolor{white}{HTML}{EEEEEE}

\colorlet{headerBackground}{white}
\colorlet{headerText}{lightgray}
\colorlet{headerEmph}{pink}
\colorlet{titleText}{blackred}
\colorlet{subTitleText}{darkred}
\colorlet{bodyText}{gray}
\colorlet{tagText}{darkgray}
\colorlet{subTagText}{lightgray}
\colorlet{accent}{lightred}

\pagenumbering{gobble}
\noexpandarg
\newcounter{index}

% Fonts
\newfontfamily{\FAB}[Path=./fonts/, Scale=0.85]{font-awesome-5-brands}
\newfontfamily{\FAR}[Path=./fonts/, Scale=0.85]{font-awesome-5-free-regular}
\newfontfamily{\FAS}[Path=./fonts/, Scale=0.85]{font-awesome-5-free-solid}
\newfontfamily\bodyfont[Path=./fonts/, ItalicFont=*-italic, Ligatures=TeX]{open-sans}
\newfontfamily\headerfont[Path=./fonts/, ItalicFont=*-italic, Ligatures=TeX]{josefin-sans}

% Header

\newcommand{\header}[4] {
  \begin{tikzpicture}[remember picture, overlay]
    \node [rectangle, anchor=north, minimum width=\paperwidth, minimum height=3.5cm] (box) at (current page.north) {};
      \node [anchor=center] (name) at (box) {
        \fontsize{30}{60}\headerfont\selectfont
        {\color{headerText} #1}{\color{headerEmph} #2}
      };
      \node [anchor=north, align=center] (contact) at (name.south) {
        \color{bodyText}\large\headerfont\selectfont #3
      };
      \node [anchor=north, align=center] (links) at (contact.south) {
        \color{bodyText}\large\headerfont\selectfont #4
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
      \vspace{0.05cm}~
      \par
      \huge\headerfont\selectfont
      \color{titleText}\LARGE##1%
      \vspace{-0.25cm}~
    }
  }

  \begin{textblock}{3.6}(1.5, 4.25)
  \begin{flushleft}
  \obeycr
  \vspace{-1.50cm}~
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
      \vspace{0.25cm}~
      \par
      \headerfont\selectfont
      \color{titleText}\LARGE##1%
      \vspace{0.10cm}~
    }
  }

  \begin{textblock}{5.8}(14.5, 4.33)
  \begin{flushleft}
  \obeycr
  \vspace{-1.50cm}~
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
  \vspace{-0.3cm}~
} {
  \end{tabular*}
  \vspace{-0.3cm}~
}

\newcommand{\checknextarg}{\@ifnextchar\bgroup{\gobblenextarg}{\end{itemize}}}
\newcommand{\gobblenextarg}[1]{\item[--] #1\@ifnextchar\bgroup{\gobblenextarg}{\end{itemize}}}
\newcommand{\createlist}[1]{
  \begin{itemize}[leftmargin=0.45cm, noitemsep, topsep=0.1cm]
    \color{bodyText}\item[--]#1\checknextarg
}

\newcommand{\rightentry}[5] {
  \bodyfont\selectfont
  \hspace{-0.05cm}\parbox[t]{12.0cm} {
    \bodyfont\selectfont
    \color{subTitleText}#2 \hfill \color{tagText}#3\\
    \color{lightred}#4 \hfill \color{subTagText}#1
    #5
  }
}

\newcommand{\iconentry}[2] {
  \parbox[t]{0.25cm}{\centering#1} \ #2
}

\def\replace#1#2#3{%
 \def\tmp##1#2{##1#3\tmp}%
   \tmp#1\stopreplace#2\stopreplace}
\def\stopreplace#1\stopreplace{}

\newcommand\separator{\color{accent}• \color{bodyText}}
\newcommand\iterate[1]{
  \replace{#1}{,}{\ \separator}
}

\newcommand\subheader[1]{
  \bodyfont\selectfont
  \vspace{0.2cm}
  \large\color{accent}#1\color{bodyText}\normalsize
}
