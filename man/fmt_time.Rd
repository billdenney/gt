% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_data.R
\name{fmt_time}
\alias{fmt_time}
\title{Format values as times}
\usage{
fmt_time(data, columns, rows = everything(), time_style = 1, pattern = "{x}")
}
\arguments{
\item{data}{A table object that is created using the \code{\link[=gt]{gt()}} function.}

\item{columns}{The columns to format. Can either be a series of column names
provided in \code{\link[=c]{c()}}, a vector of column indices, or a helper function
focused on selections. The select helper functions are: \code{\link[=starts_with]{starts_with()}},
\code{\link[=ends_with]{ends_with()}}, \code{\link[=contains]{contains()}}, \code{\link[=matches]{matches()}}, \code{\link[=one_of]{one_of()}}, \code{\link[=num_range]{num_range()}}, and
\code{\link[=everything]{everything()}}.}

\item{rows}{Optional rows to format. Providing \code{\link[=everything]{everything()}} (the
default) results in all rows in \code{columns} being formatted. Alternatively,
we can supply a vector of row captions within \code{\link[=c]{c()}}, a vector of row
indices, or a helper function focused on selections. The select helper
functions are: \code{\link[=starts_with]{starts_with()}}, \code{\link[=ends_with]{ends_with()}}, \code{\link[=contains]{contains()}}, \code{\link[=matches]{matches()}},
\code{\link[=one_of]{one_of()}}, \code{\link[=num_range]{num_range()}}, and \code{\link[=everything]{everything()}}. We can also use expressions
to filter down to the rows we need (e.g.,
\verb{[colname_1] > 100 & [colname_2] < 50}).}

\item{time_style}{The time style to use. Supply a number (from \code{1} to \code{5})
that corresponds to the preferred time style, or, provide a named time
style (\code{"hms"}, \code{"hms_p"}, \code{"h_p"}, etc.). Use \code{\link[=info_time_style]{info_time_style()}} to see
the different numbered and named time presets.}

\item{pattern}{A formatting pattern that allows for decoration of the
formatted value. The value itself is represented by \code{{x}} and all other
characters are taken to be string literals.}
}
\value{
An object of class \code{gt_tbl}.
}
\description{
Format input values to time values using one of five presets. Input can be in
the form of \code{POSIXt} (i.e., date-times), \code{character} (must be in the ISO
8601 forms of \code{HH:MM:SS} or \verb{YYYY-MM-DD HH:MM:SS}), or \code{Date} (which always
results in the formatting of \code{00:00:00}).

Once the appropriate data cells are targeted with \code{columns} (and, optionally,
\code{rows}), we can simply apply a preset time style to format the times. The
following time styles are available for use (all using the input time of
\code{14:35:00} in the example output times):
\enumerate{
\item \code{"hms"}: \code{14:35:00}
\item \code{"hm"}: \code{14:35}
\item \code{"hms_p"}: \verb{2:35:00 PM}
\item \code{"hm_p"}: \verb{2:35 PM}
\item \code{"h_p"}: \verb{2 PM}
}

We can use the \code{\link[=info_time_style]{info_time_style()}} function for a useful reference on all of
the possible inputs to \code{time_style}.
}
\details{
Targeting of values is done through \code{columns} and additionally by \code{rows} (if
nothing is provided for \code{rows} then entire columns are selected). Conditional
formatting is possible by providing a conditional expression to the \code{rows}
argument. See the \emph{Arguments} section for more information on this.
}
\section{Examples}{


Use \code{\link{exibble}} to create a \strong{gt} table. Keep only the \code{date} and \code{time}
columns. Format the \code{time} column to have times formatted as \code{hms_p} (time
style \code{3}).

\if{html}{\out{<div class="sourceCode r">}}\preformatted{exibble \%>\%
  dplyr::select(date, time) \%>\%
  gt() \%>\%
  fmt_time(
    columns = time,
    time_style = 3
  )
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_time_1.png" alt="This image of a table was generated from the first code example in the `fmt_time()` help file." style="width:100\%;">
}}

Use \code{\link{exibble}} to create a \strong{gt} table. Keep only the \code{date} and \code{time}
columns. Format the \code{time} column to have mixed time formats (times after
16:00 will be different than the others because of the expressions used
in the \code{rows} argument).

\if{html}{\out{<div class="sourceCode r">}}\preformatted{exibble \%>\%
  dplyr::select(date, time) \%>\%
  gt() \%>\%
  fmt_time(
    columns = time,
    rows = time > "16:00",
    time_style = 3
  ) \%>\%
  fmt_time(
    columns = time,
    rows = time <= "16:00",
    time_style = 4
  )
}\if{html}{\out{</div>}}

\if{html}{\out{
<img src="https://raw.githubusercontent.com/rstudio/gt/master/images/man_fmt_time_2.png" alt="This image of a table was generated from the second code example in the `fmt_time()` help file." style="width:100\%;">
}}
}

\section{Function ID}{

3-12
}

\seealso{
Other data formatting functions: 
\code{\link{data_color}()},
\code{\link{fmt_bytes}()},
\code{\link{fmt_currency}()},
\code{\link{fmt_datetime}()},
\code{\link{fmt_date}()},
\code{\link{fmt_duration}()},
\code{\link{fmt_engineering}()},
\code{\link{fmt_fraction}()},
\code{\link{fmt_integer}()},
\code{\link{fmt_markdown}()},
\code{\link{fmt_number}()},
\code{\link{fmt_partsper}()},
\code{\link{fmt_passthrough}()},
\code{\link{fmt_percent}()},
\code{\link{fmt_roman}()},
\code{\link{fmt_scientific}()},
\code{\link{fmt}()},
\code{\link{sub_large_vals}()},
\code{\link{sub_missing}()},
\code{\link{sub_small_vals}()},
\code{\link{sub_zero}()},
\code{\link{text_transform}()}
}
\concept{data formatting functions}
