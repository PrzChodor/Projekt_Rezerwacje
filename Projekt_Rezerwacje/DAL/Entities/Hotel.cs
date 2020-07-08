using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace Projekt_Rezerwacje.DAL.Entities
{
    class Hotel
    {
        public int ID { set; get; }
        public string Name { set; get; }

        public Hotel(MySqlDataReader reader)
        {
            ID = int.Parse(reader["id_h"].ToString());
            Name = reader["nazwa"].ToString();
        }

        public override string ToString()
        {
            return $"{Name}";
        }
    }
}
