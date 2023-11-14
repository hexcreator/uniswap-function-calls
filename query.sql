SELECT
  hash,
  gas_used,
  gas_price,
  bytearray_substring (data, 1, 4) as "method_id", -- expression, start, length
  bytearray_substring (data, 17, 20) as "tokenIn",
  bytearray_substring (data, 49, 20) as "tokenOut",
  bytearray_to_int256(bytearray_substring (data, 99, 2)) as "fee",
  bytearray_substring (data, 113, 20) as "recipient", 
  bytearray_to_int256(bytearray_substring (data, 161, 4)) as "deadline", 
  bytearray_to_int256(bytearray_substring (data, 190, 4)) as "amountIn", 
  bytearray_to_int256(bytearray_substring (data, 218, 4)) as "amountOutMinimum", 
  data
FROM
  ethereum.transactions
WHERE
  to = 0xE592427A0AEce92De3Edee1F18E0157C05861564 -- Uniswap V3 Router contract
  AND bytearray_substring (data, 1, 4) = 0x414bf389 -- 'exactInputSingle' method id
LIMIT
  100;
