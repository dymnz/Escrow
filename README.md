# Escrow

這個合約可以用來當作線下交易的保險

## Usage

1. 交易雙方和Broker約好佣金

2. Broker部署Contract

3. 交易雙方從各自收款地址呼叫register1()或register2()

4. 交易雙方從任意地址呼叫deposit1()/deposit2()並送出資金

5. Broker釋出雙方資金並收取佣金

交易雙方各自要放多少錢到contract裡，contract並不管。

## Safety
* 資金只有兩個流向:
  * 暫時凍結在合約  
  * 釋出到退款地址

* Broker只有在釋出資金時拿得到佣金
  * 如果遇到惡意綁架資金的Broker，交易雙方可以呼叫forceRelase()來拿回資金。
  在此情況下Broker不會拿到佣金，交易雙方拿回的資金是扣除佣金後的餘額，和普通釋出相同。
  多餘的資金會永久凍結在合約。
