test_that("the `fmt_engineering()` function works correctly", {

  # Create an input data frame with a single numeric column
  data_tbl <-
    data.frame(
      num = c(
        82030482871264190319039109717191.1,
        829300232923103939802.4,
        492032183020.5,
        84930284002.1,
        5043202435.0,
        203820929.2,
        84729202.4,
        2323435.1,
        230323.4,
        50000.01,
        1000.001,
        10.00001,
        12345,
        1234.5,
        123.45,
        1.2345,
        0.12345,
        0.0000123456,
        -50000.01,
        -1000.001,
        -10.00001,
        -12345,
        -1234.5,
        -123.45,
        -1.2345,
        -0.12345,
        -0.0000123456
      )
    )

  # Create a `gt_tbl` object with `gt()` and the
  # `data_tbl` dataset
  tab <- gt(data_tbl)

  # Expect that the object has the correct classes
  expect_s3_class(tab, c("gt_tbl", "data.frame"))

  # Expect the extracted values to match those of the
  # original dataset
  expect_equal(data_tbl$num, (tab %>% dt_data_get())[["num"]])

  # Expect an error when attempting to format a column
  # that does not exist
  expect_error(
    tab %>%
      fmt_engineering(columns = "num_3", decimals = 2)
  )

  # Expect an error when using a locale that does not exist
  expect_error(
    tab %>%
      fmt_engineering(columns = "num", decimals = 2, locale = "aa_bb")
  )

  # Format the `num` column to 2 decimal places, use all other defaults
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 2) %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("82.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup>"),
      paste0("829.30 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup>"),
      paste0("492.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("84.93 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("5.04 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("203.82 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("84.73 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("2.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("230.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "10.00",
      paste0("12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "123.45",
      "1.23",
      paste0("123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("\U02212", "50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "10.00"),
      paste0("\U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "123.45"),
      paste0("\U02212", "1.23"),
      paste0("\U02212", "123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>")
    )
  )

  # Format the `num` column to 2 decimal places, use all other defaults
  # (checking values in the `default` context)
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 2) %>%
       render_formats_test("default"))[["num"]],
    c(
      "82.03 \U000D7 10^30",
      "829.30 \U000D7 10^18",
      "492.03 \U000D7 10^9",
      "84.93 \U000D7 10^9",
      "5.04 \U000D7 10^9",
      "203.82 \U000D7 10^6",
      "84.73 \U000D7 10^6",
      "2.32 \U000D7 10^6",
      "230.32 \U000D7 10^3",
      "50.00 \U000D7 10^3",
      "1.00 \U000D7 10^3",
      "10.00",
      "12.35 \U000D7 10^3",
      "1.23 \U000D7 10^3",
      "123.45",
      "1.23",
      "123.45 \U000D7 10^-3",
      "12.35 \U000D7 10^-6",
      "-50.00 \U000D7 10^3",
      "-1.00 \U000D7 10^3",
      "-10.00",
      "-12.35 \U000D7 10^3",
      "-1.23 \U000D7 10^3",
      "-123.45",
      "-1.23",
      "-123.45 \U000D7 10^-3",
      "-12.35 \U000D7 10^-6"
    )
  )

  # Format the `num` column to 5 decimal places, use all other defaults
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 5) %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("82.03048 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup>"),
      paste0("829.30023 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup>"),
      paste0("492.03218 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("84.93028 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("5.04320 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("203.82093 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("84.72920 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("2.32344 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("230.32340 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("50.00001 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "10.00001",
      paste0("12.34500 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1.23450 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "123.45000",
      "1.23450",
      paste0("123.45000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("12.34560 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("\U02212", "50.00001 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "10.00001"),
      paste0("\U02212", "12.34500 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.23450 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "123.45000"),
      paste0("\U02212", "1.23450"),
      paste0("\U02212", "123.45000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "12.34560 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>")
    )
  )

  # Format the `num` column to 2 decimal places, use a period for the
  # digit grouping separators
  expect_equal(
    (tab %>%
       fmt_engineering(
         columns = "num", decimals = 2,
         sep_mark = ".", dec_mark = ","
       ) %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("82,03 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup>"),
      paste0("829,30 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup>"),
      paste0("492,03 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("84,93 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("5,04 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("203,82 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("84,73 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("2,32 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("230,32 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("50,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "10,00",
      paste0("12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1,23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "123,45",
      "1,23",
      paste0("123,45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("\U02212", "50,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "10,00"),
      paste0("\U02212", "12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1,23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "123,45"),
      paste0("\U02212", "1,23"),
      paste0("\U02212", "123,45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>")
    )
  )

  # Format the `num` column to 4 decimal places, scale all values by
  # 1/1000, use all other defaults
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 4, scale_by = 1/1000) %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("82.0305 ", "\U000D7", " 10<sup style='font-size: 65%;'>27</sup>"),
      paste0("829.3002 ", "\U000D7", " 10<sup style='font-size: 65%;'>15</sup>"),
      paste0("492.0322 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("84.9303 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("5.0432 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("203.8209 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("84.7292 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("2.3234 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "230.3234",
      "50.0000",
      "1.0000",
      paste0("10.0000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      "12.3450",
      "1.2345",
      paste0("123.4500 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("1.2345 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("123.4500 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("12.3456 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "9</sup>"),
      paste0("\U02212", "50.0000"),
      paste0("\U02212", "1.0000"),
      paste0("\U02212", "10.0000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "12.3450"),
      paste0("\U02212", "1.2345"),
      paste0("\U02212", "123.4500 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "1.2345 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "123.4500 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("\U02212", "12.3456 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "9</sup>")
    )
  )

  # Format the `num` column to 2 decimal places, prepend and append
  # all values by 2 different literals, use all other defaults
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 2, pattern = "a {x} b") %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("a 82.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup> b"),
      paste0("a 829.30 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup> b"),
      paste0("a 492.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup> b"),
      paste0("a 84.93 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup> b"),
      paste0("a 5.04 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup> b"),
      paste0("a 203.82 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup> b"),
      paste0("a 84.73 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup> b"),
      paste0("a 2.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup> b"),
      paste0("a 230.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      paste0("a 50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      paste0("a 1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      "a 10.00 b",
      paste0("a 12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      paste0("a 1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      "a 123.45 b",
      "a 1.23 b",
      paste0("a 123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup> b"),
      paste0("a 12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup> b"),
      paste0("a \U02212", "50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      paste0("a \U02212", "1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      paste0("a \U02212", "10.00 b"),
      paste0("a \U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      paste0("a \U02212", "1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup> b"),
      paste0("a \U02212", "123.45 b"),
      paste0("a \U02212", "1.23 b"),
      paste0("a \U02212", "123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup> b"),
      paste0("a \U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup> b")
    )
  )

  # Format the `num` column to 2 decimal places, force the sign
  expect_equal(
    (tab %>%
       fmt_engineering(
         columns = "num", decimals = 3, force_sign = TRUE) %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("+82.030 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup>"),
      paste0("+829.300 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup>"),
      paste0("+492.032 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("+84.930 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("+5.043 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("+203.821 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("+84.729 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("+2.323 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("+230.323 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("+50.000 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("+1.000 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "+10.000",
      paste0("+12.345 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("+1.234 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "+123.450",
      "+1.234",
      paste0("+123.450 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("+12.346 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("\U02212", "50.000 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.000 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "10.000"),
      paste0("\U02212", "12.345 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.234 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "123.450"),
      paste0("\U02212", "1.234"),
      paste0("\U02212", "123.450 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "12.346 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>")
    )
  )

  # Format the `num` column to 2 decimal places, force the sign and
  # define a pattern for decorating values
  expect_equal(
    (tab %>%
       fmt_engineering(
         columns = "num", pattern = "*{x}*", force_sign = TRUE) %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("*+82.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup>*"),
      paste0("*+829.30 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup>*"),
      paste0("*+492.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>*"),
      paste0("*+84.93 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>*"),
      paste0("*+5.04 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>*"),
      paste0("*+203.82 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>*"),
      paste0("*+84.73 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>*"),
      paste0("*+2.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>*"),
      paste0("*+230.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      paste0("*+50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      paste0("*+1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      "*+10.00*",
      paste0("*+12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      paste0("*+1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      "*+123.45*",
      "*+1.23*",
      paste0("*+123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>*"),
      paste0("*+12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>*"),
      paste0("*\U02212", "50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      paste0("*\U02212", "1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      paste0("*\U02212", "10.00*"),
      paste0("*\U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      paste0("*\U02212", "1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>*"),
      paste0("*\U02212", "123.45*"),
      paste0("*\U02212", "1.23*"),
      paste0("*", "\U02212", "123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>*"),
      paste0("*", "\U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>*")
    )
  )

  # Format the `num` column to 2 decimal places, apply the `en_US`
  # locale and use all other defaults
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 2, locale = "en_US") %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("82.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup>"),
      paste0("829.30 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup>"),
      paste0("492.03 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("84.93 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("5.04 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("203.82 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("84.73 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("2.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("230.32 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "10.00",
      paste0("12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "123.45",
      "1.23",
      paste0("123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("\U02212", "50.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "10.00"),
      paste0("\U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1.23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "123.45"),
      paste0("\U02212", "1.23"),
      paste0("\U02212", "123.45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "12.35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>")
    )
  )

  # Format the `num` column to 2 decimal places, apply the `da_DK`
  # locale and use all other defaults
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 2, locale = "da_DK") %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("82,03 ", "\U000D7", " 10<sup style='font-size: 65%;'>30</sup>"),
      paste0("829,30 ", "\U000D7", " 10<sup style='font-size: 65%;'>18</sup>"),
      paste0("492,03 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("84,93 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("5,04 ", "\U000D7", " 10<sup style='font-size: 65%;'>9</sup>"),
      paste0("203,82 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("84,73 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("2,32 ", "\U000D7", " 10<sup style='font-size: 65%;'>6</sup>"),
      paste0("230,32 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("50,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "10,00",
      paste0("12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("1,23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      "123,45",
      "1,23",
      paste0("123,45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>"),
      paste0("\U02212", "50,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1,00 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "10,00"),
      paste0("\U02212", "12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "1,23 ", "\U000D7", " 10<sup style='font-size: 65%;'>3</sup>"),
      paste0("\U02212", "123,45"),
      paste0("\U02212", "1,23"),
      paste0("\U02212", "123,45 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "3</sup>"),
      paste0("\U02212", "12,35 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "6</sup>")
    )
  )
})

test_that("`fmt_engineering() can handle extremely large and small values", {

  # Create an input data frame with very large and very small numbers
  # (both positive and negative)
  data_tbl <-
    data.frame(
      num = c(
        -1.5E200, -1.5E100, -2.5E0, -3.5E-100, -3.5E-200,
        1.5E-200, 1.5E-100, 2.5E0, 3.5E100, 3.5E200
      )
    )

  # Create a `gt_tbl` object with `gt()` and the`data_tbl` dataset
  tab <- gt(data_tbl)

  # Format the `num` column to 5 decimal places, use all other defaults
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 5) %>%
       render_formats_test("html"))[["num"]],
    c(
      paste0("\U02212", "150.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>198</sup>"),
      paste0("\U02212", "15.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>99</sup>"),
      paste0("\U02212", "2.50000"),
      paste0("\U02212", "350.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "102</sup>"),
      paste0("\U02212", "35.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "201</sup>"),
      paste0("15.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "201</sup>"),
      paste0("150.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>", "\U02212", "102</sup>"),
      "2.50000",
      paste0("35.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>99</sup>"),
      paste0("350.00000 ", "\U000D7", " 10<sup style='font-size: 65%;'>198</sup>")
    )
  )

  # Format the `num` column to 5 decimal places, use all
  # other defaults; extract values in the default context
  # and compare to expected values
  # (checking values in the `default` context)
  expect_equal(
    (tab %>%
       fmt_engineering(columns = "num", decimals = 5) %>%
       render_formats_test("default"))[["num"]],
    c(
      "-150.00000 \U000D7 10^198",
      "-15.00000 \U000D7 10^99",
      "-2.50000",
      "-350.00000 \U000D7 10^-102",
      "-35.00000 \U000D7 10^-201",
      "15.00000 \U000D7 10^-201",
      "150.00000 \U000D7 10^-102",
      "2.50000",
      "35.00000 \U000D7 10^99",
      "350.00000 \U000D7 10^198"
    )
  )
})
