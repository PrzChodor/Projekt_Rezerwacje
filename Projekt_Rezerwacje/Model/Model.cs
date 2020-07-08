using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;

namespace Projekt_Rezerwacje.Model
{
    using DAL.Entities;
    using DAL.Repositories;
    using System.Windows;
    using System.Windows.Controls;

    class Model
    {
        public ObservableCollection<Room> Rooms { get; set; } = new ObservableCollection<Room>();
        public ObservableCollection<Reservation> Reservations { get; set; } = new ObservableCollection<Reservation>();
        public ObservableCollection<Client> Clients { get; set; } = new ObservableCollection<Client>();
        public ObservableCollection<Client> SearchedClients { get; set; } = new ObservableCollection<Client>();
        public string SearchedClient { get; set; }

      
        public Model()
        {
            var clients = ClientRepository.GetClients();
            foreach (var c in clients)
                Clients.Add(c);
        }

        public void GetRooms(int id_h, string package)
        {
            Rooms.Clear();
            var rooms = RoomRepository.GetRooms(id_h, package);
            foreach (var r in rooms)
                Rooms.Add(r);
        }

        public void SearchForClient(string SearchedClient)
        {
            SearchedClients.Clear();
            var clients = ClientRepository.SearchClient(SearchedClient);
            foreach (var c in clients)
                SearchedClients.Add(c);
        }

        public bool IsClientInDataBase(Client client) => Clients.Contains(client);


        public bool AddClient(Client client)
        {
            if (!IsClientInDataBase(client))
            {
                if (ClientRepository.AddClient(client))
                {
                    Clients.Add(client);
                    return true;
                }
            }
            return false;    
        }

        public bool EditClient(Client client, int clientID)
        {
            if (ClientRepository.EditClient(client, clientID))
            {
                for (int i = 0; i < Clients.Count; i++)
                {
                    if (Clients[i].ID == clientID)
                    {
                        client.ID = clientID;
                        Clients[i] = new Client(client);
                    }
                }
                return true;
            }
            return false;
        }

        public bool DeleteClient(Client client, int clientID)
        {
            if (IsClientInDataBase(client))
            {
                if (ClientRepository.DeleteClient(clientID))
                {
                    Clients.Remove(client);
                    return true;
                }
            }
            return false;
        }

        public bool IsReservationInDataBase(Reservation reservation) => Reservations.Contains(reservation);

        public void GetReservations(int id_p)
        {
            Reservations.Clear();
            var reserv = ReservationRepository.GetReservations(id_p);
            foreach (var r in reserv)
            {
                Reservations.Add(r);
            }
        }

        public bool AddReservation(Reservation reservation, int id_p)
        {
            if (!IsReservationInDataBase(reservation))
            {
                if (ReservationRepository.AddReservation(reservation, id_p))
                {
                    Reservations.Add(reservation);
                    return true;
                }
            }
            else
                System.Windows.MessageBox.Show($"Rezerwacja jest już w bazie!");
            return false;
        }
        public bool DeleteReservation(Reservation reservation, int reservationID)
        {
            if (IsReservationInDataBase(reservation))
            {
                if (ReservationRepository.DeleteReservation(reservationID))
                {
                    Reservations.Remove(reservation);
                    return true;
                }
            }
            return false;
        }
    }
}
