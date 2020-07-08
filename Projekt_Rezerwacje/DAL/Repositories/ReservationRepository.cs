using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Projekt_Rezerwacje.DAL.Repositories
{
    using DAL.Entities;
    using System.Windows;

    class ReservationRepository
    {
        private const string ADD_RESERVATION = "INSERT INTO `rezerwacje`(`id_k`, `od`, `do`) VALUES ";
        private const string ADD_RESERVATION_ROOM = "INSERT INTO `pokoje_rezerwacje`(`id_r`, `id_p`) VALUES ";

        public static List<Reservation> GetReservations(int id_p)
        {
            string ROOM_RESERVATIONS = "SELECT * FROM rezerwacje, klienci, pokoje_rezerwacje  " +
                $"WHERE rezerwacje.id_k = klienci.id_k AND rezerwacje.id_r = pokoje_rezerwacje.id_r AND pokoje_rezerwacje.id_p = {id_p}";

            List<Reservation> reservations = new List<Reservation>();
            using (var connection = DBConnection.Instance.Connection)
            {
                MySqlCommand command = new MySqlCommand(ROOM_RESERVATIONS, connection);
                connection.Open();
                var reader = command.ExecuteReader();
                while (reader.Read())
                    reservations.Add(new Reservation(reader));
                connection.Close();
            }
            return reservations;
        }

        public static bool DeleteReservation(int reservationID)
        {
            bool state = false;
            using (var connection = DBConnection.Instance.Connection)
            {
                string DELETE_RESERVATION = $"DELETE FROM pokoje_rezerwacje WHERE id_r={reservationID}; DELETE FROM rezerwacje WHERE id_r ={ reservationID}";
              
                MySqlCommand command = new MySqlCommand(DELETE_RESERVATION, connection);
                connection.Open();
                var n = command.ExecuteNonQuery();
                if (n == 2) state = true;
                connection.Close();
            }
            return state;
        }

        public static bool AddReservation(Reservation reservation, int id_p)
        {
            bool state = false;
            int n = 0;
            using (var connection = DBConnection.Instance.Connection)
            {
                string DATES_IN_RANGE = $"SELECT COUNT(*) FROM rezerwacje, pokoje_rezerwacje WHERE " +
                    $"((od BETWEEN '{reservation.StartDate:yyyy-MM-dd}'  AND '{reservation.EndDate:yyyy-MM-dd}')  OR " +
                    $"(do BETWEEN '{reservation.StartDate:yyyy-MM-dd}'  AND '{reservation.EndDate:yyyy-MM-dd}')  OR " +
                    $"('{reservation.StartDate:yyyy-MM-dd}' BETWEEN od and do )) AND " +
                    $"rezerwacje.id_r = pokoje_rezerwacje.id_r AND pokoje_rezerwacje.id_p = {id_p}";

                MySqlCommand command = new MySqlCommand(DATES_IN_RANGE, connection);
                connection.Open();
                n = int.Parse(command.ExecuteScalar().ToString());
                connection.Close();
            }

            if (n > 0)
            {
                MessageBox.Show("W tych dniach pokój jest zajęty!");
                return false;
            }

            using (var connection = DBConnection.Instance.Connection)
            {
                MySqlCommand command = new MySqlCommand($"{ADD_RESERVATION} {reservation.ToInsert()}", connection);
                connection.Open();
                var id = command.ExecuteNonQuery();
                reservation.ID = (int)command.LastInsertedId;
                connection.Close();
            }
            using (var connection = DBConnection.Instance.Connection)
            {
                MySqlCommand command = new MySqlCommand($"{ADD_RESERVATION_ROOM} ({reservation.ID}, {id_p})", connection);
                connection.Open();
                var id = command.ExecuteNonQuery();
                state = true;
                connection.Close();
            }
            return state;
        }
    }
}
