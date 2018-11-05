using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace FirstProject
{
    public class Session
    {
        public byte loggedIn = 0;
        private int userID;
        private string pseudoLocation;
        private string dutyCode;
        private string initials;
        private string username;
        private string password;
        private string savedCmd = null;
        private Dictionary<int, string> activeSearch = new Dictionary<int, string>();
        public SqlConnection connection = new SqlConnection("Server=localhost\\SQLEXPRESS;Database=SABRE;Trusted_Connection=True;");
        public SqlDataReader sqlOutput = null;
        public Dictionary<string, string> monthAbbr = new Dictionary<string, string>();
        private string activePNR;

        public void Login()
        {
            while (loggedIn == 0)
            {
                Console.Clear();
                Console.WriteLine("SIGN IN A");
                username = Console.ReadLine();
                password = null;
                while (true)
                {
                    var key = Console.ReadKey(true);
                    if (key.Key == ConsoleKey.Enter)
                        break;
                    password += key.KeyChar;
                }
                if (string.IsNullOrEmpty(username))
                {
                    username = "";
                }
                if (string.IsNullOrEmpty(password))
                {
                    password = "";
                }
                CheckLogin(username, password.ToUpper());
            }
        }
        public void CheckLogin(string username, string password)
        {
            if (connection.State == System.Data.ConnectionState.Closed)
            {
                connection.Open();
            }
            SqlCommand searchUsers = new SqlCommand("SELECT userID, firstName, lastName, dutyCode, pseudoLocation  FROM Users WHERE userID = @username AND password = @password AND active = 1", connection);
            try
            {
                searchUsers.Parameters.Add(new SqlParameter("username", username));
                searchUsers.Parameters.Add(new SqlParameter("password", password));
                sqlOutput = searchUsers.ExecuteReader();
                if (!sqlOutput.HasRows)
                {
                    sqlOutput.Close();
                    sqlOutput = null;
                    connection.Close();
                    Login();
                }
                else
                {
                    userID = Convert.ToInt32(username);
                    while(sqlOutput.Read())
                    {
                        pseudoLocation = sqlOutput["pseudoLocation"].ToString();
                        dutyCode = sqlOutput["dutyCode"].ToString();
                        initials = Left(sqlOutput["firstName"].ToString(), 1) + Left(sqlOutput["lastName"].ToString(), 1);
                    }
                    loggedIn = 1;
                    sqlOutput.Close();
                    sqlOutput = null;
                    connection.Close();
                    CMD(ReturnHome(1));
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("SYSTEM ERROR: A1 /n" + ex.ToString());
                Console.ReadLine();
            }
        }
        
        public string ReturnHome(byte home)
        {
            if (home == 1)
            {
                Console.Clear();
                Console.WriteLine($"{pseudoLocation}.{pseudoLocation}{dutyCode}A{initials}.A");
            }
            return Console.ReadLine();
        }

        public string ReturnHome(int userID, string initials, string pseudoLocation, string dutyCode)
        {
            Console.Clear();
            Console.WriteLine($"{pseudoLocation}.{pseudoLocation}{dutyCode}A{initials}.A");
            return Console.ReadLine();
        }

        public string Left(string input, int length)
        {
            if (input.Length >= length)
            {
                return input.Substring(0,length);
            }
            else
            {
                return input;
            }
        }

        public string Right(string input, int length)
        {
            if (input.Length >= length)
            {
                return input.Substring(input.Length - length);
            } else
            {
                return input;
            }
        }

        public void CMD(string cmd)
        {
            cmd = cmd.ToUpper();
            //CPA
            if (Left(cmd, 1) == "1" && (cmd.Length == 12 || cmd.Length == 14 || cmd.Length == 15 || cmd.Length == 17))
            {
                savedCmd = cmd;
                Console.Clear();
                Console.WriteLine(cmd);
                switch (cmd.Length)
                {
                    case 12:
                        CPA(cmd.Substring(1, 5), cmd.Substring(6, 3), cmd.Substring(9, 3), "AA", 0);
                        break;
                    case 14:
                        CPA(cmd.Substring(1, 7), cmd.Substring(8, 3), cmd.Substring(11, 3), "AA", 0);
                        break;
                    case 15:
                        CPA(cmd.Substring(1, 5), cmd.Substring(6, 3), cmd.Substring(9, 3), cmd.Substring(13, 2), 0);
                        break;
                    case 17:
                        CPA(cmd.Substring(1, 7), cmd.Substring(8, 3), cmd.Substring(11, 3), cmd.Substring(15, 2), 0);
                        break;
                }
                //SO*
            } else if (savedCmd != null && cmd == "1*" && (savedCmd.Length == 12 || savedCmd.Length == 13 || savedCmd.Length == 15 || savedCmd.Length == 16 || savedCmd.Length == 18))
            {
                if (Char.IsNumber(Convert.ToChar(Right(savedCmd, 1))))
                {
                    savedCmd = Left(savedCmd, savedCmd.Length - 1) + Convert.ToString(Convert.ToInt16(Right(savedCmd, 1)) + 1);
                }
                else
                {
                    savedCmd = savedCmd + Convert.ToString(1);
                }
                switch (savedCmd.Length)
                {
                    case 13:
                        CPA(savedCmd.Substring(1, 5), savedCmd.Substring(6, 3), savedCmd.Substring(9, 3), "AA", Convert.ToInt32(Right(savedCmd, 1)));
                        break;
                    case 15:
                        CPA(savedCmd.Substring(1, 7), savedCmd.Substring(8, 3), savedCmd.Substring(11, 3), "AA", Convert.ToInt32(Right(savedCmd, 1)));
                        break;
                    case 16:
                        CPA(savedCmd.Substring(1, 5), savedCmd.Substring(6, 3), savedCmd.Substring(9, 3), savedCmd.Substring(13, 2), Convert.ToInt32(Right(savedCmd, 1)));
                        break;
                    case 18:
                        CPA(savedCmd.Substring(1, 7), savedCmd.Substring(8, 3), savedCmd.Substring(11, 3), savedCmd.Substring(15, 2), Convert.ToInt32(Right(savedCmd, 1)));
                        break;
                }
            } else if (Left(cmd, 1) == "2" && (cmd.Length == 11 || cmd.Length == 13 || cmd.Length == 15))
            {
                Console.Clear();
                Console.WriteLine(cmd);
                string part1 = Left(cmd, cmd.IndexOf("/"));
                string part2 = Right(cmd, cmd.Length - (cmd.IndexOf("/") + 1));
                string tempAirline;
                int tempFlightNum = Convert.ToInt32(Right(part1, 4));
                if (part1.Length == 5)
                {
                    tempAirline = "AA";
                }
                else
                {
                    tempAirline = part1.Substring(1, 2);
                }
                FLIFO(tempAirline, tempFlightNum, part2);
            } else if (Left(cmd, 1) == "*" && cmd.Length == 7)
            {
                Console.Clear();
                Console.WriteLine(cmd);
                SearchPNR(Right(cmd.ToUpper(), 6));
            } else if (Left(cmd, 2) == "*-")
            {
                if (!cmd.Contains("/"))
                {
                    SearchPNR(cmd.Substring(2), 1);
                }
                else
                {
                    SearchPNR(cmd.Substring(2, cmd.IndexOf("/") - 2), cmd.Substring(cmd.IndexOf("/") + 1));
                }
            }
            else if (Left(cmd, 1) == "*" && cmd.Length == 2)
            {
                SearchPNR(activeSearch[Convert.ToInt32(cmd.Substring(1))]);
            } else if (Left(cmd, 1) == "-" && cmd.Length != 3) {
                Console.Clear();
                Console.WriteLine(cmd);
                addNames(cmd);
            } else if (Left(cmd, 1) == "-" && cmd.Length == 3) {
                Console.Clear();
                Console.WriteLine(cmd);
                RemoveNames(cmd);
            } else if (Left(cmd,1) == "0")
            {
                SellSegment(cmd);
            } else if (cmd == "`")
            {
                CMD(ReturnHome(1));
            } else if (cmd == "SO*")
            {
                loggedIn = 0;
            } else
            {
                Console.Clear();
                Console.WriteLine(cmd);
                Console.WriteLine("COMMAND ERROR - COMMAND NOT FOUND");
                CMD(ReturnHome(0));
            }
        }

        public void CPA(string deptDate, string deptCity, string arrivalCity, string airline, int page)
        {
            int i = (page * 5) + 1;
            DateTime deptDate2;
            connection.Open();
            SqlCommand searchFlights = new SqlCommand("SELECT *, " +
                "((SELECT COUNT(*) FROM Seats WHERE equipment = F.equipment AND class = 'F') - (SELECT COUNT(*) FROM Tickets T JOIN Priority P ON T.priorityID = P.priorityID WHERE flightID = F.flightID AND class = 'F' AND P.NRSA = 0)) AS [totalF], " +
                "((SELECT COUNT(*) FROM Seats WHERE equipment = F.equipment AND class = 'J') - (SELECT COUNT(*) FROM Tickets T JOIN Priority P ON T.priorityID = P.priorityID WHERE flightID = F.flightID AND class = 'J' AND P.NRSA = 0)) AS [totalJ], " +
                "((SELECT COUNT(*) FROM Seats WHERE equipment = F.equipment AND class = 'M') - (SELECT COUNT(*) FROM Tickets T JOIN Priority P ON T.priorityID = P.priorityID WHERE flightID = F.flightID AND class = 'M' AND P.NRSA = 0)) AS [totalM], " +
                "((SELECT COUNT(*) FROM Seats WHERE equipment = F.equipment AND class = 'Y') - (SELECT COUNT(*) FROM Tickets T JOIN Priority P ON T.priorityID = P.priorityID WHERE flightID = F.flightID AND class = 'Y' AND P.NRSA = 0)) AS [totalY], " +
                "FORMAT(deptDate, 'hhmmt') AS [deptTime], CASE WHEN DAY(arrivalDate) > DAY(deptDate) THEN FORMAT(arrivalDate, 'hhmmt') + '+1' ELSE FORMAT(arrivalDate, 'hhmmt') END AS [arrivalTime] " +
                "FROM Flights F " +
                "WHERE CAST(deptDate AS DATE) = @deptDate " +
                "AND deptCity = @deptCity " +
                "AND arrivalCity = @arrivalCity " +
                "AND airline = @airline " +
                "ORDER BY deptDate, flightNum " +
                "OFFSET " + Convert.ToString(page * 5) + " ROWS " +
                "FETCH NEXT 5 ROWS ONLY", connection);
            try
            {
                deptDate2 = DateTime.Parse(monthAbbr[deptDate.Substring(2, 3)] + "/" + deptDate.Substring(0, 2) + "/" + DateTime.Today.Year);
                if (deptDate2 < DateTime.Today)
                {
                    deptDate2 = deptDate2.AddYears(1);
                }
                searchFlights.Parameters.Add(new SqlParameter("deptDate", deptDate2));
                searchFlights.Parameters.Add(new SqlParameter("deptCity", deptCity));
                searchFlights.Parameters.Add(new SqlParameter("arrivalCity", arrivalCity));
                searchFlights.Parameters.Add(new SqlParameter("airline", airline));
                sqlOutput = searchFlights.ExecuteReader();
                if (!sqlOutput.HasRows)
                {
                    Console.WriteLine("NO FLIGHTS FOUND");
                }
                else
                {
                    if (activeSearch.Count == 0)
                    {
                        activeSearch.Clear();
                    }
                    while (sqlOutput.Read())
                    {
                        activeSearch.Add(i, sqlOutput["flightID"].ToString());
                        Console.WriteLine($"{i,2}{sqlOutput["airline"].ToString(),-4}{sqlOutput["FlightNum"].ToString(),-4} " +
                            $"F{Math.Min(Convert.ToInt32(sqlOutput["totalF"].ToString()),9)} " +
                            $"J{Math.Min(Convert.ToInt32(sqlOutput["totalJ"].ToString()), 9)} " +
                            $"M{Math.Min(Convert.ToInt32(sqlOutput["totalM"].ToString()), 9)} " +
                            $"Y{Math.Min(Convert.ToInt32(sqlOutput["totalY"].ToString()), 9)}*" +
                            $"{sqlOutput["deptCity"].ToString(),-3}{sqlOutput["arrivalCity"].ToString(),-3} " +
                            $"{sqlOutput["deptTime"].ToString(),-7}{sqlOutput["arrivalTime"].ToString(),-7} " +
                            $"{sqlOutput["equipment"].ToString(),-5} 0 DCA /E");
                        i++;
                    }
                }
                sqlOutput.Close();
                sqlOutput = null;
                connection.Close();
            }
            catch
            {
                Console.WriteLine("COMMAND ERROR");
            }
            CMD(ReturnHome(0));
        }

        public void FLIFO(string airline, int flightNum, string deptDate)
        {
            int i = 1;
            DateTime deptDate2;
            connection.Open();
            SqlCommand searchFlights = new SqlCommand("SELECT *, FORMAT(deptDate, 'hhmmt') AS [deptTime], CASE WHEN DAY(arrivalDate) > DAY(deptDate) THEN FORMAT(arrivalDate, 'hhmmt') + '+1' ELSE FORMAT(arrivalDate, 'hhmmt') END AS [arrivalTime] " +
                "FROM Flights " +
                "WHERE CAST(deptDate AS DATE) = @deptDate " +
                "AND flightNum = @flightNum " +
                "AND airline = @airline " +
                "ORDER BY deptDate, flightNum", connection);
            try
            {
                deptDate2 = DateTime.Parse(monthAbbr[deptDate.Substring(2, 3)] + "/" + deptDate.Substring(0, 2) + "/" + DateTime.Today.Year);
                if (deptDate2 < DateTime.Today)
                {
                    deptDate2 = deptDate2.AddYears(1);
                }
                searchFlights.Parameters.Add(new SqlParameter("deptDate", deptDate2));
                searchFlights.Parameters.Add(new SqlParameter("flightNum", flightNum));
                searchFlights.Parameters.Add(new SqlParameter("airline", airline));
                sqlOutput = searchFlights.ExecuteReader();
                if (!sqlOutput.HasRows)
                {
                    Console.WriteLine("NO FLIGHTS FOUND");
                }
                else
                {
                    if (activeSearch.Count == 0)
                    {
                        activeSearch.Clear();
                    }
                    while (sqlOutput.Read())
                    {
                        activeSearch.Add(i, sqlOutput["flightID"].ToString());
                        Console.WriteLine($"{i,2}{sqlOutput["airline"].ToString(),-4}{sqlOutput["FlightNum"].ToString(),-4} {sqlOutput["deptCity"].ToString(),-3}{sqlOutput["arrivalCity"].ToString(),-3} {sqlOutput["deptTime"].ToString(),-7}{sqlOutput["arrivalTime"].ToString(),-7} {sqlOutput["equipment"].ToString(),-5} 0 DCA /E");
                        i++;
                    }
                }
                sqlOutput.Close();
                sqlOutput = null;
                connection.Close();
            }
            catch
            {
                Console.WriteLine("COMMAND ERROR");
            }
            CMD(ReturnHome(0));
        }

        public void SearchPNR(string pnrID)
        {
            connection.Open();
            SqlCommand searchPassengers = new SqlCommand("SELECT lastName, firstName, passengerID, LEAD(lastName, 1) OVER (ORDER BY lastName, firstName) AS [nxtLastName], " +
                "DENSE_RANK() OVER (ORDER BY lastName ASC) AS [lastNameIteration], ROW_NUMBER() OVER (PARTITION BY lastName ORDER BY lastName, firstName ASC) AS [firstNameIteration], " +
                "COUNT(*) OVER (PARTITION BY lastName) AS [count], ROW_NUMBER() OVER (ORDER BY lastName, firstName ASC) AS [totalCount] " +
                "FROM Passengers " +
                "WHERE pnrID = @pnrID " +
                "ORDER BY lastName, firstName", connection);
            try
            {
                searchPassengers.Parameters.Add(new SqlParameter("pnrID", pnrID));
                sqlOutput = searchPassengers.ExecuteReader();
                int lastPassengerID = 0;
                int passengerCount = 0;
                if (!sqlOutput.HasRows)
                {
                    Console.WriteLine("NO PNR FOUND");

                }
                else
                {
                    while (sqlOutput.Read())
                    {
                        if (sqlOutput["firstNameIteration"].ToString() == "1")
                        {
                            Console.Write($"{sqlOutput["lastNameIteration"].ToString(),2}.{sqlOutput["count"].ToString()}{sqlOutput["lastName"].ToString()}/{sqlOutput["firstName"].ToString()}");
                        }
                        else
                        {
                            Console.Write($"/{sqlOutput["firstName"]}");
                        }
                        if (sqlOutput["firstNameIteration"].ToString() == sqlOutput["count"].ToString())
                        {
                            Console.Write("\n");
                        }
                        lastPassengerID = Convert.ToInt32(sqlOutput["passengerID"].ToString());
                        passengerCount = Convert.ToInt32(sqlOutput["totalCount"].ToString());
                    }
                    sqlOutput.Close();
                    sqlOutput = null;
                    SqlCommand searchItinerary = new SqlCommand("SELECT ROW_NUMBER() OVER (ORDER BY F.deptDate ASC) AS [iteration], airline, flightNum, class, " +
                        "UPPER(FORMAT(F.deptDate, 'ddMMM')) AS [deptDate], (deptCity + arrivalCity) AS [cityPair], P.summaryAbbreviation, FORMAT(deptDate, 'hhmmt') AS [deptTime], " +
                        "CASE WHEN DAY(arrivalDate) > DAY(deptDate) THEN FORMAT(arrivalDate, 'hhmmt') + '+1' ELSE FORMAT(arrivalDate, 'hhmmt') END AS [arrivalTime] " +
                        "FROM Tickets T " +
                        "JOIN Flights F ON T.flightID = F.flightID " +
                        "JOIN Priority P ON T.priorityID = P.priorityID " +
                        "WHERE T.passengerID = @passengerID " +
                        "ORDER BY F.deptDate ASC", connection);
                    searchItinerary.Parameters.Add(new SqlParameter("passengerID", lastPassengerID));
                    sqlOutput = searchItinerary.ExecuteReader();
                    if (!sqlOutput.HasRows)
                    {
                        Console.WriteLine(" NO ITINERARY");
                    }
                    else
                    {
                        while (sqlOutput.Read())
                        {
                            Console.WriteLine($"{sqlOutput["iteration"].ToString(),2} {sqlOutput["airline"].ToString()} {sqlOutput["flightNum"].ToString()}{sqlOutput["class"].ToString()} {sqlOutput["deptDate"].ToString()} S {sqlOutput["cityPair"].ToString()} {sqlOutput["summaryAbbreviation"]}{passengerCount} {sqlOutput["deptTime"].ToString()} {sqlOutput["arrivalTime"].ToString(),-7} /E");
                        }
                    }
                }
                sqlOutput.Close();
                sqlOutput = null;
                connection.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("COMMAND ERROR " + ex.ToString());
            }
            CMD(ReturnHome(0));
        }

        public void SearchPNR(string lastName, int byLastName)
        {
            connection.Open();
            SqlCommand searchPNRs = new SqlCommand("SELECT PNR.pnrID, MAX(P.firstName) AS firstName, MAX(P.lastName) AS lastName, MAX(F.deptCity) AS deptCity, UPPER(FORMAT(MIN(deptDate), 'ddMMM')) AS deptDate, (SELECT COUNT(*) FROM Passengers WHERE pnrID = PNR.pnrID) AS totalCount " +
                "FROM PNR " +
                "JOIN Passengers P ON PNR.pnrID = P.pnrID AND P.primaryPassenger = 1 " +
                "JOIN Tickets T ON P.passengerID = T.passengerID " +
                "JOIN Flights F ON T.flightID = F.flightID " +
                "WHERE P.lastName LIKE @lastName " +
                "GROUP BY PNR.pnrID " +
                "HAVING MIN(F.deptDate) >= DATEADD(MONTH, -6, GETDATE()) " +
                "ORDER BY MAX(P.lastName), MAX(P.firstName), MIN(F.deptDate) ASC", connection);
            try
            {
                searchPNRs.Parameters.Add(new SqlParameter("lastName", $"%{lastName}%"));
                sqlOutput = searchPNRs.ExecuteReader();
                if (!sqlOutput.HasRows)
                {
                    Console.WriteLine("NO PNR FOUND");
                }
                else
                {
                    int i = 0;
                    while (sqlOutput.Read())
                    {
                        i++;
                    }
                    sqlOutput.Close();
                    sqlOutput = null;
                    sqlOutput = searchPNRs.ExecuteReader();
                    if (i == 1)
                    {
                        SearchPNR(sqlOutput["pnrID"].ToString());
                    }
                    else
                    {
                        i = 1;
                        if (activeSearch.Count != 0)
                            {
                                activeSearch.Clear();
                            }
                        while (sqlOutput.Read())
                        {
                            activeSearch.Add(i, $"{sqlOutput["pnrID"].ToString()}");
                            Console.WriteLine($"{i,3}  {sqlOutput["totalCount"].ToString()}{sqlOutput["lastName"].ToString()}/{sqlOutput["firstName"].ToString(),-20} {sqlOutput["deptCity"].ToString()} {sqlOutput["deptDate"].ToString()} {sqlOutput["pnrID"].ToString()}");
                            i++;
                        }
                    }
                }
                sqlOutput.Close();
                sqlOutput = null;
                connection.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("COMMAND ERROR " + ex.ToString());
            }
            CMD(ReturnHome(0));
        }

        public void SearchPNR(string lastName, string firstName)
        {
            connection.Open();
            Console.WriteLine($"*-{lastName}/{firstName}");
            SqlCommand searchPNRs = new SqlCommand("SELECT PNR.pnrID, MAX(P.firstName) AS firstName, MAX(P.lastName) AS lastName, MAX(F.deptCity) AS deptCity, UPPER(FORMAT(MIN(deptDate), 'ddMMM')) AS deptDate, (SELECT COUNT(*) FROM Passengers WHERE pnrID = PNR.pnrID) AS totalCount " +
                "FROM PNR " +
                "JOIN Passengers P ON PNR.pnrID = P.pnrID AND P.primaryPassenger = 1 " +
                "JOIN Tickets T ON P.passengerID = T.passengerID " +
                "JOIN Flights F ON T.flightID = F.flightID " +
                "WHERE P.lastName LIKE @lastName AND P.firstName LIKE @firstName " +
                "GROUP BY PNR.pnrID " +
                "HAVING MIN(F.deptDate) >= DATEADD(MONTH, -6, GETDATE()) " +
                "ORDER BY MAX(P.lastName), MAX(P.firstName), MIN(F.deptDate) ASC", connection);
            try
            {
                searchPNRs.Parameters.Add(new SqlParameter("lastName", $"%{lastName}%"));
                searchPNRs.Parameters.Add(new SqlParameter("firstName", $"%{firstName}%"));
                sqlOutput = searchPNRs.ExecuteReader();
                if (!sqlOutput.HasRows)
                {
                    Console.WriteLine("NO PNR FOUND");
                }
                else
                {
                    int i = 0;
                    while (sqlOutput.Read())
                    {
                        i++;
                    }

                    sqlOutput.Close();
                    sqlOutput = null;
                    sqlOutput = searchPNRs.ExecuteReader();
                    if (activeSearch.Count != 0)
                    {
                        activeSearch.Clear();
                    }
                    int j = 1;
                    while (sqlOutput.Read())
                    {
                        if (i == 1)
                        {
                            SearchPNR(sqlOutput["pnrID"].ToString());
                        }
                        else
                        {
                            activeSearch.Add(j, $"{sqlOutput["pnrID"].ToString()}");
                            Console.WriteLine($"{j,3}  {sqlOutput["totalCount"].ToString()}{sqlOutput["lastName"].ToString()}/{sqlOutput["firstName"].ToString(),-20} {sqlOutput["deptCity"].ToString()} {sqlOutput["deptDate"].ToString()} {sqlOutput["pnrID"].ToString()}");
                            j++;
                        }
                    }
                }
                sqlOutput.Close();
                sqlOutput = null;
                connection.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("COMMAND ERROR " + ex.ToString());
            }
            CMD(ReturnHome(0));
        }
        public void addNames(string cmd)
        {
            if (String.IsNullOrEmpty(activePNR))
            {
                Random random = new Random();
                string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                StringBuilder newPNR = new StringBuilder(6);
                for (int i = 0; i < 6; i++)
                {
                    newPNR.Append(characters[random.Next(characters.Length)]);
                }
                activePNR = newPNR.ToString();
                connection.Open();
                SqlCommand insertPNR = new SqlCommand("INSERT INTO TempPNR (tempPNRID) VALUES ('" + activePNR + "')", connection);
                try
                {
                    int result = insertPNR.ExecuteNonQuery();
                    if (result == 0)
                    {
                        Console.WriteLine("SYSTEM ERROR -- INPUT NOT SUCCESSFUL");
                        throw new ArgumentException("THE PNR COULD NOT BE CREATED");
                    }
                }
                catch (Exception ex) 
                {
                    Console.WriteLine("COMMAND ERROR " + ex.ToString());
                }
                connection.Close();
            }
            string query = null;
            List<int> flightList = new List<int>();
            connection.Open();
            SqlCommand getFlights = new SqlCommand("SELECT C.flightID FROM TempTickets A JOIN TempPassengers B ON A.tempPassengerID = B.tempPassengerID JOIN Flights C ON A.flightID = C.flightID " +
                "WHERE B.tempPNRID = '" + activePNR + "' " +
                "GROUP BY C.flightID " +
                "ORDER BY MAX(C.deptDate)", connection);
            try
            {
                sqlOutput = getFlights.ExecuteReader();
                if (!sqlOutput.HasRows)
                {

                }
                else
                {
                    while (sqlOutput.Read())
                    {
                        flightList.Add(Convert.ToInt32(sqlOutput["flightID"].ToString()));
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("COMMAND ERROR " + ex.ToString());
            }
            sqlOutput.Close();
            sqlOutput = null;
            connection.Close();
            if (cmd.Substring(1, 1).All(char.IsDigit))
            {
                string lastName = cmd.Substring(2, cmd.IndexOf('/') - 2);
                List<string> tempNames = cmd.Substring(cmd.IndexOf('/') + 1).Split('/').ToList();
                int i;
                for (i = 0; i < Convert.ToInt16(cmd.Substring(1,1)); i++)
                {
                    query += "INSERT INTO TempPassengers (firstName, lastName, tempPNRID, primaryPassenger) VALUES ('" + tempNames[i] + "', '" + lastName + "', '" + activePNR + "', " +
                        "CASE WHEN (SELECT COUNT(*) FROM TempPassengers WHERE tempPNRID = '" + activePNR + "' AND primaryPassenger = 1) = 0 THEN 1 ELSE 0 END);";
                    if (flightList.Count != 0)
                    {
                        int j;
                        for (j = 0; j < flightList.Count; j++)
                        {
                            query += "INSERT INTO TempTickets (tempPassengerID, flightID, seat, priorityID, class) " +
                                "VALUES ((SELECT tempPassengerID FROM TempPassengers WHERE tempPNRID = '" + activePNR + "' AND firstName = '" + tempNames[i] + "' AND lastName = '" + lastName + "'), " + flightList[j] + ", " +
                                "(SELECT A.seat " +
                                "FROM Seats A " +
                                "JOIN Flights B ON B.flightID = 1 " +
                                "LEFT JOIN Tickets C ON C.flightID = B.flightID AND C.priorityID IN(SELECT priorityID FROM Priority WHERE NRSA = 0) AND C.seat = A.seat " +
                                "LEFT JOIN TempTickets D on D.flightID = B.flightID AND C.priorityID IN(SELECT priorityID FROM Priority WHERE NRSA = 0) AND C.seat = A.seat " +
                                "WHERE A.equipment = B.equipment AND C.ticketID IS NULL AND D.tempTicketID IS NULL AND A.class = 'F' " +
                                "ORDER BY A.id " +
                                "OFFSET 0 ROWS " +
                                "FETCH NEXT 1 ROW ONLY), ";
                            if (j == 0)
                            {
                                //through
                                query += "CASE" +
                                         "WHEN(SELECT A.seat " +
                                         "FROM Seats A " +
                                         "JOIN Flights B ON B.flightID = 1 " +
                                         "LEFT JOIN Tickets C ON C.flightID = B.flightID AND C.priorityID IN(SELECT priorityID FROM Priority WHERE NRSA = 0) AND C.seat = A.seat " +
                                         "LEFT JOIN TempTickets D on D.flightID = B.flightID AND C.priorityID IN(SELECT priorityID FROM Priority WHERE NRSA = 0) AND C.seat = A.seat " +
                                         "WHERE A.equipment = B.equipment AND C.ticketID IS NULL AND D.tempTicketID IS NULL AND A.class = 'F' AND 1 = 0) IS NULL THEN 2 " +
                                         "ELSE 14 " +
                                         "END, " +
                                         "''); ";
                            } else
                            {
                                //not through
                            }
                        }
                    }
                }
            }
            else
            {
                string lastName = cmd.Substring(1, cmd.IndexOf('/') - 1);
                query = "INSERT INTO TempPassengers (firstName, lastName, tempPNRID, primaryPassenger) VALUES ('" + cmd.Substring(cmd.IndexOf('/') + 1) + "', '" + lastName + "', '" + activePNR + "', " +
                        "CASE WHEN (SELECT COUNT(*) FROM TempPassengers WHERE tempPNRID = '" + activePNR + "' AND primaryPassenger = 1) = 0 THEN 1 ELSE 0 END);";
            }
            //run query
            
            connection.Open();
            SqlCommand insertPassengers = new SqlCommand(query, connection);
            try
            {
                int result = insertPassengers.ExecuteNonQuery();
                if (result == 0)
                {
                    Console.WriteLine("SYSTEM ERROR -- INPUT NOT SUCCESSFUL");
                    throw new ArgumentException("THE PASSENGER(S) COULD NOT BE CREATED");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("COMMAND ERROR " + ex.ToString());
            }
            connection.Close();
            Console.WriteLine("*");
            CMD(ReturnHome(0));
        }
        public void RemoveNames(string cmd)
        {
            if (activePNR == null)
            {
                Console.WriteLine("SYSTEM ERROR");
                throw new ArgumentException("NO ACTIVE PNR IN WORKAREA");
            }
            else
            {
                int name = Convert.ToInt16(cmd.Substring(1, 1));
                connection.Open();
                SqlCommand deletePassengers = new SqlCommand("DELETE FROM TempPassengers WHERE tempPNRID = '" + activePNR + "' AND lastName = (SELECT lastName " +
                "FROM TempPassengers " +
                "WHERE tempPNRID = '" + activePNR + "' " +
                "GROUP BY lastName " +
                "ORDER BY MAX(CAST(primaryPassenger AS int)) DESC, MAX(lastName), MAX(tempPassengerID) " +
                "OFFSET " + Convert.ToString((name - 1)) + " ROWS " +
                "FETCH NEXT 1 ROWS ONLY)", connection);
                try
                {
                    int result = deletePassengers.ExecuteNonQuery();
                    if (result == 0)
                    {
                        Console.WriteLine("SYSTEM ERROR -- DELETE NOT SUCCESSFUL");
                        throw new ArgumentException("NO PASSENGERS WERE DELETED");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("COMMAND ERROR " + ex.ToString());
                }
                connection.Close();
                Console.WriteLine("*");
                CMD(ReturnHome(0));
            }
        }
        public void SellSegment(string cmd)
        {
            if (activePNR == null)
            {
                Console.WriteLine("SYSTEM ERROR");
                throw new ArgumentException("NO ACTIVE PNR IN WORKAREA");
            }
            else
            {
                int numSeats = Convert.ToInt16(cmd.Substring(1, 1));
                char classOfService = Convert.ToChar(cmd.Substring(2, 1));
                int iteration = Convert.ToInt16(cmd.Substring(3, 1));
                connection.Open();
                SqlCommand getPassengers = new SqlCommand("SELECT tempPassengerID FROM TempPassengers WHERE tempPNRID = '" + activePNR + "'", connection);
                try
                {
                    sqlOutput = getPassengers.ExecuteReader();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("COMMAND ERROR " + ex.ToString());
                }
                sqlOutput.Close();
                sqlOutput = null;
                connection.Close();
            }
        }
    }
    public class PNR
    {
        public string pnrID;

        public PNR (string PnrID)
        {
            pnrID = PnrID;
        }

    }
    public class Ticket
    {
        public int ticketID;
        public int flightID;
        public int passengerID;
        public string priority;

        public Ticket (int TicketID, int FlightID, int PassengerID, string Priority)
        {
            ticketID = TicketID;
            flightID = FlightID;
            passengerID = PassengerID;
            priority = Priority;
        }
    }
    public class Passengers
    {
        public Dictionary<int, string> lastNames { get; set; }
        public List<string> allNames { get; set; }

        /*public Passengers (Dictionary<int, string> LastNames)
        {
            lastNames = LastNames;
        }*/
    }
    public class PassengerGroup
    {
        public string lastName { get; set; }
        public int passengerCount { get; set; }
        public List<string> firstNames { get; set; }

        public PassengerGroup (string LastName, int PassengerCount, List<string> FirstNames)
        {
            lastName = LastName;
            passengerCount = PassengerCount;
            firstNames = FirstNames;
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            Console.BackgroundColor = ConsoleColor.DarkBlue;
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.Clear();
            Session activeSession = new Session();
            activeSession.monthAbbr.Add("JAN", "01");
            activeSession.monthAbbr.Add("FEB", "02");
            activeSession.monthAbbr.Add("MAR", "03");
            activeSession.monthAbbr.Add("APR", "04");
            activeSession.monthAbbr.Add("MAY", "05");
            activeSession.monthAbbr.Add("JUN", "06");
            activeSession.monthAbbr.Add("JUL", "07");
            activeSession.monthAbbr.Add("AUG", "08");
            activeSession.monthAbbr.Add("SEP", "09");
            activeSession.monthAbbr.Add("OCT", "10");
            activeSession.monthAbbr.Add("NOV", "11");
            activeSession.monthAbbr.Add("DEC", "12");
            activeSession.Login();
        }
    }
}
