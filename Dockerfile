FROM julia:1.4

# Install IJulia and jupyterlab via conda
RUN julia -e "using Pkg; Pkg.add(\"IJulia\"); using IJulia"
RUN julia -e "using Pkg; Pkg.add(\"Conda\"); using Conda; Conda.add(\"jupyterlab\"); Pkg.rm(\"Conda\")"

# Create workspace for user files.
RUN mkdir /workspace
WORKDIR /workspace

# Configure jupyterlab server
EXPOSE 8888
RUN mkdir /root/.jupyter
COPY ./jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

CMD ["sh", "-c", "/root/.julia/conda/3/bin/jupyter-lab --allow-root"]
