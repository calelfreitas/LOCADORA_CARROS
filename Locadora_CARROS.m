import tkinter as tk
from tkinter import ttk

frota = {
    "Chevrolet": [
        {"Modelo": "Onix", "Cor": "Prata", "Ano": 2023, "Km_Litro": 13.5},
        {"Modelo": "Tracker", "Cor": "Preto", "Ano": 2024, "Km_Litro": 11.2},
        {"Modelo": "Cruze", "Cor": "Branco", "Ano": 2022, "Km_Litro": 10.8},
        {"Modelo": "Joy Plus 1.4", "Cor": "Prata", "Ano": 2022, "Km_Litro": 12.0}
    ],
    "Ford": [
        {"Modelo": "Ranger", "Cor": "Cinza", "Ano": 2023, "Km_Litro": 9.5},
        {"Modelo": "Territory", "Cor": "Azul", "Ano": 2024, "Km_Litro": 11.0}
    ],
    "Fiat": [
        {"Modelo": "Argo", "Cor": "Vermelho", "Ano": 2023, "Km_Litro": 13.9},
        {"Modelo": "Pulse", "Cor": "Cinza", "Ano": 2024, "Km_Litro": 12.0},
        {"Modelo": "Toro", "Cor": "Preto", "Ano": 2022, "Km_Litro": 10.5}
    ],
    "Peugeot": [
        {"Modelo": "208", "Cor": "Azul", "Ano": 2023, "Km_Litro": 13.0},
        {"Modelo": "2008", "Cor": "Branco", "Ano": 2024, "Km_Litro": 11.8}
    ],
    "BYD": [
        {"Modelo": "Dolphin", "Cor": "Rosa", "Ano": 2024, "Km_Litro": 35.0},
        {"Modelo": "Song Plus", "Cor": "Preto", "Ano": 2024, "Km_Litro": 22.5}
    ],
    "Hyundai": [
        {"Modelo": "HB20", "Cor": "Prata", "Ano": 2023, "Km_Litro": 13.3},
        {"Modelo": "Creta", "Cor": "Branco", "Ano": 2024, "Km_Litro": 11.5}
    ],
    "Jeep": [
        {"Modelo": "Renegade", "Cor": "Verde", "Ano": 2023, "Km_Litro": 11.0},
        {"Modelo": "Compass", "Cor": "Preto", "Ano": 2024, "Km_Litro": 10.2}
    ],
    "Toyota": [
        {"Modelo": "Corolla", "Cor": "Prata", "Ano": 2023, "Km_Litro": 14.5},
        {"Modelo": "Yaris", "Cor": "Vermelho", "Ano": 2024, "Km_Litro": 13.8},
        {"Modelo": "Hilux", "Cor": "Branco", "Ano": 2022, "Km_Litro": 10.1}
    ],
    "Volkswagen": [
        {"Modelo": "Polo", "Cor": "Cinza", "Ano": 2024, "Km_Litro": 13.8},
        {"Modelo": "Nivus", "Cor": "Preto", "Ano": 2023, "Km_Litro": 12.1},
        {"Modelo": "T-Cross", "Cor": "Azul", "Ano": 2024, "Km_Litro": 11.9}
    ],
    "Mitsubishi": [
        {"Modelo": "Eclipse Cross", "Cor": "Vermelho", "Ano": 2023, "Km_Litro": 10.9},
        {"Modelo": "L200 Triton", "Cor": "Prata", "Ano": 2022, "Km_Litro": 9.8}
    ],
    "BMW": [
        {"Modelo": "320i", "Cor": "Preto", "Ano": 2024, "Km_Litro": 10.6},
        {"Modelo": "X3", "Cor": "Branco", "Ano": 2023, "Km_Litro": 9.9}
    ]
}

PRECO_COMBUSTIVEL = 5.80

def atualizar_tabela(event=None):
    for item in tree_carros.get_children():
        tree_carros.delete(item)
    
    marca = combo_marcas.get()
    dist_str = entry_distancia.get().strip().replace(",", ".")

    if not marca:
        return

    try:
        distancia = float(dist_str)
        if distancia <= 0:
            return
    except ValueError:
        return

    carros = frota.get(marca, [])
    melhor_carro = max(carros, key=lambda c: c["Km_Litro"])

    for carro in carros:
        litros = distancia / carro["Km_Litro"]
        custo = litros * PRECO_COMBUSTIVEL
        tag = "melhor" if carro == melhor_carro else "normal"

        tree_carros.insert(
            "", "end",
            values=(carro["Modelo"], carro["Cor"], carro["Ano"], f"{carro['Km_Litro']} km/l", f"{litros:.1f} L", f"R$ {custo:.2f}"),
            tags=(tag,)
        )


def limpar():
    combo_marcas.set("")
    entry_distancia.delete(0, tk.END)
    entry_distancia.insert(0, "0")
    lbl_status.config(text="", fg="#8A8A8A")
    for item in tree_carros.get_children():
        tree_carros.delete(item)

# IG
janela = tk.Tk()
janela.title("Locadora de Veículos")
janela.geometry("620x480")
janela.configure(bg="#1E1E2E")

style = ttk.Style()
style.theme_use("clam")
style.configure("Treeview", background="#2A2A3D", foreground="#FFFFFF", fieldbackground="#2A2A3D", font=("Segoe UI", 10), rowheight=26)
style.configure("Treeview.Heading", background="#3B3B54", foreground="#FFFFFF", font=("Segoe UI", 10, "bold"))

frame = tk.Frame(janela, bg="#1E1E2E", padx=15, pady=15)
frame.pack(expand=True, fill="both")

tk.Label(frame, text="LOCADORA DE VEÍCULOS", font=("Segoe UI", 14, "bold"), fg="#00FFB9", bg="#1E1E2E").pack(pady=(0, 10))

# Painel superior (Marca + Distância + Botão Limpar)
frame_top = tk.Frame(frame, bg="#1E1E2E")
frame_top.pack(fill="x", pady=(0, 10))

tk.Label(frame_top, text="Marca:", font=("Segoe UI", 10, "bold"), fg="#FFFFFF", bg="#1E1E2E").pack(side="left", padx=(0, 5))
combo_marcas = ttk.Combobox(frame_top, values=sorted(list(frota.keys())), state="readonly", font=("Segoe UI", 10), width=30)
combo_marcas.pack(side="left", padx=(0, 15))
combo_marcas.bind("<<ComboboxSelected>>", atualizar_tabela)

tk.Label(frame_top, text="Distância (Km):", font=("Segoe UI", 10, "bold"), fg="#FFFFFF", bg="#1E1E2E").pack(side="left", padx=(0, 5))
entry_distancia = tk.Entry(frame_top, font=("Segoe UI", 10), width=8, bg="#2A2A3D", fg="#FFFFFF", insertbackground="#FFFFFF", bd=0)
entry_distancia.insert(0, "0")
entry_distancia.pack(side="left", padx=(0, 15))
entry_distancia.bind("<KeyRelease>", atualizar_tabela)

# Botão limpar
btn_limpar = tk.Button(frame_top, text="LIMPAR", font=("Segoe UI", 9, "bold"), bg="#3B3B54", fg="#FFFFFF", bd=0, padx=12, pady=2, command=limpar, cursor="hand2")
btn_limpar.pack(side="left")

lbl_status = tk.Label(frame, text="Selecione uma marca para ver a frota.", font=("Segoe UI", 9), fg="#8A8A8A", bg="#1E1E2E")
lbl_status.pack(fill="x", pady=(0, 10))

# Tabela
colunas = ("Modelo", "Cor", "Ano", "Km/L", "Litros Néc.", "Custo Est.")
tree_carros = ttk.Treeview(frame, columns=colunas, show="headings", height=8)

for col in colunas:
    tree_carros.heading(col, text=col)
    tree_carros.column(col, anchor="center", width=80)

tree_carros.tag_configure("melhor", background="#1E4620", foreground="#00FFB9")
tree_carros.tag_configure("normal", background="#2A2A3D", foreground="#FFFFFF")
tree_carros.pack(fill="both", expand=True)

janela.mainloop()