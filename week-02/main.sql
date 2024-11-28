-- 2
-- select proname,
--        soldtotal,
--        pricetotal
--   from (
--    select product.proname,
--           sum(saledetail.amount) as soldtotal,
--           sum(saledetail.itemtotal) as pricetotal,
--           rank()
--           over(
--               order by sum(saledetail.itemtotal) desc
--           ) as rnk
--      from product
--      join saledetail
--    on product.productid = saledetail.proid
--      join sale
--    on sale.saleid = saledetail.saleid
--     where to_char(
--       sale.saledate,
--       'MM'
--    ) = '04'
--     group by product.proname
-- )
--  where rnk <= 2;

-- 2 Teacher Version
-- select product.proname,
--        sum(saledetail.amount)
--   from sale
--   join saledetail
-- on sale.saleid = saledetail.saleid
--   join product
-- on product.productid = saledetail.proid
--  where to_char(
--    sale.saledate,
--    'mm'
-- ) = '04'
--  group by saledetail.proid,
--           product.proname
-- having sum(saledetail.amount) in (
--    select sum(saledetail.amount)
--      from sale
--      join saledetail
--    on sale.saleid = saledetail.saleid
--     where to_char(
--       sale.saledate,
--       'mm'
--    ) = '04'
--     group by saledetail.proid
--    having sum(saledetail.amount) >= (
--       select max(sum(saledetail.amount))
--         from sale
--         join saledetail
--       on sale.saleid = saledetail.saleid
--        where to_char(
--          sale.saledate,
--          'mm'
--       ) = '04'
--        group by saledetail.proid
--       having sum(saledetail.amount) < (
--          select max(sum(saledetail.amount))
--            from sale
--            join saledetail
--          on sale.saleid = saledetail.saleid
--           where to_char(
--             sale.saledate,
--             'mm'
--          ) = '04'
--           group by saledetail.proid
--       )
--    )
-- );


-- 3
-- select product.proname
--   from product
--  where product.productid not in (
--    select saledetail.proid
--      from sale
--      join saledetail
--    on sale.saleid = saledetail.saleid
--     where to_char(
--       saledate,
--       'mm/yyyy'
--    ) = '02/2024'
-- );

-- 3 Teacher Version
-- select product.proname
--   from product
--  where product.productid not in (
--    select saledetail.proid
--      from sale
--      join saledetail
--    on sale.saleid = saledetail.saleid
--     where to_char(
--       saledate,
--       'mm/yyyy'
--    ) = '02/2024'
-- );

-- 4
select cus.name as name,
       product.proname as proname,
       temp2.sumamount as sumamount
  from (
   select sale.cusid,
          saledetail.proid,
          sum(saledetail.amount) as sumamount
     from sale
     join saledetail
   on sale.saleid = saledetail.saleid
    group by sale.cusid,
             saledetail.proid
) temp2

  join (
   select temp.cusid,
          max(temp.sumamount) as maxpurchase
     from (
      select sale.cusid,
             saledetail.proid,
             sum(saledetail.amount) as sumamount
        from sale
        join saledetail
      on sale.saleid = saledetail.saleid
       group by sale.cusid,
                saledetail.proid
   ) temp
    group by temp.cusid
) temp1

on temp1.cusid = temp2.cusid
   and temp1.maxpurchase = temp2.sumamount
  join product
on product.productid = temp2.proid
  join cus
on cus.cusid = temp2.cusid;

-- 4 Teacher Version
select cus.name,
       product.proname,
       temp2.sumamount
  from (
   select sale.cusid,
          saledetail.proid,
          sum(saledetail.amount) as sumamount
     from sale
     join saledetail
   on sale.saleid = saledetail.saleid
    group by sale.cusid,
             saledetail.proid
) temp2,
       (
          select temp.cusid,
                 max(sumamount) as maxpurchase
            from (
             select sale.cusid,
                    saledetail.proid,
                    sum(saledetail.amount) as sumamount
               from sale
               join saledetail
             on sale.saleid = saledetail.saleid
              group by sale.cusid,
                       saledetail.proid
              order by sale.cusid
          ) temp
           group by temp.cusid
       ) temp1,
       product,
       cus
 where temp1.cusid = temp2.cusid
   and temp1.maxpurchase = temp2.sumamount
   and product.productid = temp2.proid
   and cus.cusid = temp2.cusid;
